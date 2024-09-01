import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../entities/contact.dart';
import '../../services/connection_checker/connection_checker.dart';
import '../../utils/strings.dart';
import '../../widgets/after_first_frame_mixin.dart';
import '../../widgets/c_icon_button.dart';
import '../../widgets/c_outdated_data_info.dart';
import '../../widgets/c_snack_bar_mixin.dart';
import '../contact/contact_dialog_mixin.dart';
import 'contact_tile.dart';
import 'contacts_cubit.dart';
import 'debug_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsCubit()..init(),
      child: ContactsView(),
    );
  }
}

class ContactsView extends StatefulWidget {
  ContactsView({IMyConnectionChecker? connectionChecker, super.key}) : connectionChecker = connectionChecker ?? GetIt.I.get<IMyConnectionChecker>();

  final IMyConnectionChecker connectionChecker;

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> with ContactDialogMixin, CSnackBarMixin, AfterFirstFrameMixin {
  static const _heightOfTwoContactTile = 2 * 150;

  final _scrollController = ScrollController();
  final _isRefreshingList = ValueNotifier<bool>(false);

  @override
  FutureOr<void> afterFirstFrame(BuildContext context) {
    _scrollController.addListener(() => _onListBottom(context));
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(() => _onListBottom(context))
      ..dispose();
    _isRefreshingList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.connectionChecker,
      builder: (_, hasConnection, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(Strings.contacts),
            actions: [
              CIconButton(icon: Icons.delete_sweep_outlined, onPressed: () => _deleteAll(context)),
              CIconButton(icon: Icons.add_circle_outline, onPressed: () => _create(context)),
            ],
            leading: hasConnection ? const Icon(Icons.wifi, color: Colors.greenAccent) : const Icon(Icons.wifi_off, color: Colors.redAccent),
            bottom: DebugBar(
              height: hasConnection ? 48 : 80,
              child: hasConnection ? null : const COutdatedDataInfo(text: Strings.contactsDesynchronized),
            ),
          ),
          body: child,
        );
      },
      child: BlocConsumer<ContactsCubit, ContactsState>(
        listener: (_, state) {
          if (state is ContactsFailure) {
            showSnackBarForError(context, text: state.failure.messageForUser);
          }
        },
        builder: (_, state) {
          if (state is ContactsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => _refreshList(context),
            child: ListView(
              controller: _scrollController,
              children: [
                ...state.contacts.map<Widget>((contact) => ContactTile(
                      contact,
                      onEdit: () async => _edit(context, contact),
                      onDelete: () async => _delete(context, contact),
                      onOpenDocument: () async => _openDocument(context, contact),
                    )),
                if (state is ContactsListLoading) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ],
              // itemBuilder: (_, index) {
              //   return ContactTile(state.contacts[index]);
              // },
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteAll(BuildContext context) async {
    await context.read<ContactsCubit>().deleteAll().then((value) async {
      showSnackBarForSuccess(context, text: 'All contacts deleted.');
      await context.read<ContactsCubit>().refreshList();
    });
  }

  Future<void> _create(BuildContext context) async {
    await showContactDialog(context).then((hasSaved) async {
      if (hasSaved) {
        await context.read<ContactsCubit>().updateList();
      }
    });
  }

  Future<void> _edit(BuildContext context, Contact contact) async {
    await showContactDialog(context, contact: contact).then((hasSaved) async {
      if (hasSaved) {
        await context.read<ContactsCubit>().updateList();
      }
    });
  }

  Future<void> _delete(BuildContext context, Contact contact) async {
    await context.read<ContactsCubit>().delete(contact).then((_) {
      showSnackBarForSuccess(context, text: Strings.contactDeleteMessage);
    });
  }

  // TODO arrumar melhor a estrutura do open document
  Future<void> _openDocument(BuildContext context, Contact contact) async {
    await context.read<ContactsCubit>().openDocument(contact);
  }

  Future<void> _refreshList(BuildContext context) async {
    await context.read<ContactsCubit>().refreshList();
  }

  void _onListBottom(BuildContext context) {
    if (_scrollController.hasClients) {
      final maxHeightToCallGetMore = _scrollController.position.maxScrollExtent - _heightOfTwoContactTile;

      if (_scrollController.position.pixels > maxHeightToCallGetMore && !_isRefreshingList.value && !context.read<ContactsCubit>().state.isLastPage) {
        _isRefreshingList.value = true;
        context.read<ContactsCubit>().getMore().whenComplete(() {
          _isRefreshingList.value = false;
        });
      }
    }
  }
}
