import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/contact.dart';
import '../../failures/empty_name_validation_failure.dart';
import '../../services/pick/pick.dart';
import '../../services/result/failure.dart';
import '../../utils/strings.dart';
import '../../widgets/after_first_frame_mixin.dart';
import '../../widgets/c_attach_file.dart';
import '../../widgets/c_avatar.dart';
import '../../widgets/c_button.dart';
import '../../widgets/c_icon_button.dart';
import '../../widgets/c_snack_bar_mixin.dart';
import '../../widgets/c_text_field.dart';
import 'contact_cubit.dart';

mixin ContactDialogMixin {
  /// Shows contact detail screen to add a new one or update it.
  ///
  /// returns
  ///   true if is saved
  ///   false if back clicked or dialog closed without save data
  Future<bool> showContactDialog(BuildContext context, {Contact contact = const Contact.noData()}) async {
    return await showDialog(
        context: context,
        useSafeArea: true,
        barrierDismissible: false,
        builder: (_) {
          return ContactDialog(contact: contact);
        });
  }
}

class ContactDialog extends StatelessWidget {
  ContactDialog({Contact contact = const Contact.noData(), ContactCubit? contactCubit, super.key})
      : _contactCubit = contactCubit ?? ContactCubit(contact);

  final ContactCubit _contactCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactCubit>(
      create: (_) => _contactCubit,
      child: const ContactView(),
    );
  }
}

class ContactView extends StatefulWidget {
  const ContactView({super.key});

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> with AfterFirstFrameMixin, CSnackBarMixin {
  final _nameController = TextEditingController();
  final _documentPathNotifier = ValueNotifier<String>('');

  @override
  FutureOr<void> afterFirstFrame(BuildContext context) {
    final state = context.read<ContactCubit>().state;
    if (state is ContactInitial && state.isEdit) {
      _nameController.text = state.originalContact.name;
      _documentPathNotifier.value = state.originalContact.documentPhonePath;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _documentPathNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContactCubit, ContactState>(
      listener: (_, state) async {
        if (state is ContactFailure) {
          showSnackBarForError(context, text: state.failure.messageForUser);
        } else if (state is ContactLoaded && state.successMessage.isNotEmpty) {
          showSnackBarForSuccess(context, text: state.successMessage);
        }
      },
      child: WillPopScope(
          onWillPop: () async {
            await _onBackPressed(context);
            return false;
          },
          child: AlertDialog(
            iconPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: CIconButton(
                    icon: Icons.close_outlined,
                    onPressed: () => _onBackPressed(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 16),
                  child: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                    BlocSelector<ContactCubit, ContactState, bool>(
                      selector: (state) => state.isEdit,
                      builder: (_, isEdit) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(),
                            BlocSelector<ContactCubit, ContactState, File?>(
                              selector: (state) => state.temporaryAvatarFile,
                              builder: (_, temporaryAvatarFile) {
                                return GestureDetector(
                                  onTap: () => _pickAvatar(context),
                                  child: CAvatar(temporaryAvatarFile, size: 120),
                                );
                              },
                            ),
                            if (isEdit)
                              CButton.icon(
                                Icons.delete,
                                onPressed: () => _deleteContact(context),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    BlocSelector<ContactCubit, ContactState, Failure>(
                      selector: (state) => state.failure,
                      builder: (_, failure) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CTextField(
                            title: Strings.contactName,
                            textController: _nameController,
                            validationMessageError: (failure == const EmptyNameValidationFailure()) ? failure.messageForUser : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CAttachFile(
                        title: Strings.contactDocument,
                        hint: Strings.contactDocumentHint,
                        icon: Icons.picture_as_pdf_outlined,
                        filePathNotifier: _documentPathNotifier,
                        onPressed: _pickPdf,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _nameController,
                        builder: (_, name, __) {
                          return CButton(
                            Strings.contactSave,
                            onPressed: name.text.isNotEmpty ? () => _saveContact(context) : null,
                          );
                        }),
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _pickAvatar(BuildContext context) async {
    await Pick.image().then((imagePath) async {
      if (imagePath.isNotEmpty) {
        await context.read<ContactCubit>().setTemporaryAvatar(temporaryAvatarPath: imagePath);
      }
    });
  }

  Future<void> _pickPdf() async {
    // TODO arrumar aqui
    final filePath = await Pick.pdf();
    _documentPathNotifier.value = filePath;
  }

  Future<void> _saveContact(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await context
        .read<ContactCubit>()
        .save(
          name: _nameController.text,
          documentPhonePath: _documentPathNotifier.value,
        )
        .then((_) async {
      await _onEntityModified(context);
    });
  }

  Future<void> _deleteContact(BuildContext context) async {
    await context.read<ContactCubit>().delete().then((_) async {
      await _onEntityModified(context);
    });
  }

  Future<void> _onBackPressed(BuildContext context) async {
    Navigator.pop(context, false);
  }

  Future<void> _onEntityModified(BuildContext context) async {
    Navigator.pop(context, true);
  }
}
