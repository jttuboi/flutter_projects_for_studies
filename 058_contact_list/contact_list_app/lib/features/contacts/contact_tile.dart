import 'dart:async';

import 'package:flutter/material.dart';

import '../../entities/contact.dart';
import '../../utils/strings.dart';
import '../../utils/typedefs.dart';
import '../../widgets/after_first_frame_mixin.dart';
import '../../widgets/c_avatar.dart';
import '../../widgets/c_button.dart';
import '../../widgets/c_snack_bar_mixin.dart';
import '../contact/contact_dialog_mixin.dart';
import 'data_tile.dart';

class ContactTile extends StatefulWidget {
  const ContactTile(this.contact,
      {this.initialShowData = false, required this.onEdit, required this.onDelete, required this.onOpenDocument, super.key});

  final Contact contact;
  final bool initialShowData;
  final FunctionCallback onEdit;
  final FunctionCallback onDelete;
  final FunctionCallback onOpenDocument;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> with AfterFirstFrameMixin, ContactDialogMixin, CSnackBarMixin {
  final _showData = ValueNotifier<bool>(false);
  final _avatarKeyNotifier = ValueNotifier<String>('');

  @override
  FutureOr<void> afterFirstFrame(BuildContext context) {
    _showData.value = widget.initialShowData;
    _avatarKeyNotifier.value = widget.contact.id;
  }

  @override
  void dispose() {
    _showData.dispose();
    _avatarKeyNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ValueListenableBuilder<bool>(
        valueListenable: _showData,
        builder: (_, showData, child) {
          return Column(
            children: [
              DataTile(widget.contact, showData: showData, child: child!),
              const SizedBox(height: 8),
              const Divider(height: 1, thickness: 1, color: Colors.grey),
            ],
          );
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CAvatar(widget.contact.avatarFile),
          const SizedBox(width: 4),
          Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(Strings.contactsName(name: widget.contact.name, syncStatus: widget.contact.syncStatus.name)),
            const SizedBox(height: 4),
            if (widget.contact.documentUrl.isNotEmpty)
              CButton(Strings.contactsOpenDocument(widget.contact.documentPhonePath), onPressed: widget.onOpenDocument),
            const SizedBox(height: 4),
            CButton(Strings.contactsShowData, onPressed: _onShowDataPressed),
          ]),
          const Spacer(),
          Column(children: [
            CButton.icon(Icons.edit, onPressed: widget.onEdit),
            const SizedBox(height: 16),
            CButton.icon(Icons.delete, onPressed: widget.onDelete),
          ]),
        ]),
      ),
    );
  }

  void _onShowDataPressed() {
    _showData.value = !_showData.value;
  }
}
