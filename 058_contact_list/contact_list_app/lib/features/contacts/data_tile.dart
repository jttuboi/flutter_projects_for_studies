import 'package:flutter/material.dart';

import '../../entities/contact.dart';
import '../../widgets/c_text_tile.dart';

class DataTile extends StatelessWidget {
  const DataTile(this.contact, {required this.showData, required this.child, super.key});

  final Contact contact;
  final bool showData;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      child,
      if (showData) ...[
        const SizedBox(height: 4),
        CTextTile(title: 'id', text: contact.id),
        const SizedBox(height: 4),
        CTextTile(title: 'name', text: contact.name),
        const SizedBox(height: 4),
        CTextTile(title: 'avatarUrl', text: contact.avatarUrl),
        const SizedBox(height: 4),
        CTextTile(title: 'documentUrl', text: contact.documentUrl),
        const SizedBox(height: 4),
        CTextTile(title: 'documentPhonePath', text: contact.documentPhonePath),
        const SizedBox(height: 4),
        CTextTile(title: 'createdAt', text: contact.createdAt?.toIso8601String() ?? 'null'),
        const SizedBox(height: 4),
        CTextTile(title: 'updatedAt', text: contact.updatedAt?.toIso8601String() ?? 'null'),
        const SizedBox(height: 4),
        CTextTile(title: 'syncStatus', text: contact.syncStatus.name),
        const SizedBox(height: 4),
        CTextTile(title: 'avatarFile', text: contact.avatarFile?.path ?? 'null'),
      ],
    ]);
  }
}
