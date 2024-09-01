import 'dart:io';

import 'package:equatable/equatable.dart';

import 'sync_status.dart';

class Contact with EquatableMixin {
  const Contact({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.documentUrl,
    this.documentPhonePath = '',
    this.createdAt,
    this.updatedAt,
    this.syncStatus = SyncStatus.synced,
    this.avatarFile,
  });

  const Contact.noData()
      : id = '',
        name = '',
        avatarUrl = '',
        documentUrl = '',
        documentPhonePath = '',
        createdAt = null,
        updatedAt = null,
        syncStatus = SyncStatus.synced,
        avatarFile = null;

  final String id;
  final String name;
  final String avatarUrl;
  final String documentUrl;
  final String documentPhonePath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SyncStatus syncStatus;

  final File? avatarFile;

  @override
  List<Object?> get props => [id, name, avatarUrl, documentUrl, documentPhonePath, createdAt, updatedAt, syncStatus, avatarFile];

  @override
  bool? get stringify => true;

  static const tableName = 'contact';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAvatarUrl = 'avatar_url';
  static const columnDocumentUrl = 'document_url';
  static const columnDocumentPhonePath = 'document_phone_path';
  static const columnCreatedAt = 'created_at';
  static const columnUpdatedAt = 'updated_at';
  static const columnSyncStatus = 'sync_status';

  bool get hasData => id.isNotEmpty; //this == const Contact.noData();

  bool get hasNotData => id.isEmpty; //this != const Contact.noData();

  Contact copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    String? documentUrl,
    String? documentPhonePath,
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
    File? avatarFile,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      documentPhonePath: documentPhonePath ?? this.documentPhonePath,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      avatarFile: avatarFile ?? this.avatarFile,
    );
  }

  @override
  String toString() {
    return 'Contact('
        'id: $id, '
        'name: $name, '
        'avatarUrl: $avatarUrl, '
        'documentUrl: $documentUrl, '
        'documentPhonePath: $documentPhonePath, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'syncStatus: $syncStatus, '
        'avatarFile: $avatarFile'
        ')';
  }

  String toShortString() {
    return 'Contact('
        'id: ...${id.substring(id.length - 4)}, '
        'name: $name, '
        'aUrl: ${avatarUrl.split('/').last}, '
        'dUrl: ${documentUrl.split('/').last}, '
        'dPth: ${documentPhonePath.split('/').last}, '
        'crAt: ${createdAt?.toShortString()}, '
        'upAt: ${updatedAt?.toShortString()}, '
        'sySt: ${syncStatus.name}, '
        'aFil: ${avatarFile?.path}, '
        ')';
  }
}

extension ContactExtension on Contact {
  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map[Contact.columnId] ?? '',
      name: map[Contact.columnName] ?? '',
      avatarUrl: map[Contact.columnAvatarUrl] ?? '',
      documentUrl: map[Contact.columnDocumentUrl] ?? '',
      documentPhonePath: map[Contact.columnDocumentPhonePath] ?? '',
      createdAt: DateTime.tryParse(map[Contact.columnCreatedAt] ?? ''),
      updatedAt: DateTime.tryParse(map[Contact.columnUpdatedAt] ?? ''),
      syncStatus: SyncStatusExtension.fromString(map[Contact.columnSyncStatus]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Contact.columnId: id,
      Contact.columnName: name,
      Contact.columnAvatarUrl: avatarUrl,
      Contact.columnDocumentUrl: documentUrl,
      Contact.columnDocumentPhonePath: documentPhonePath,
      Contact.columnCreatedAt: createdAt?.toIso8601String(),
      Contact.columnUpdatedAt: updatedAt?.toIso8601String(),
      Contact.columnSyncStatus: syncStatus.name,
    };
  }
}

extension ContactsExtension on List<Contact> {
  static List<Contact> fromEntitiesMap(Map<String, dynamic> map) {
    final maps = map['entities'] as List;

    return maps.map<Contact>((map) => ContactExtension.fromMap(map)).toList();
  }

  Map<String, dynamic> toEntitiesMap(Map<String, File> files) {
    return {
      'entities': map<Map<String, dynamic>>((contact) => contact.toMap()).toList(),
      'files': null,
    };
  }

  Map<String, dynamic> toCountMap() {
    return {
      'count': length,
    };
  }
}

extension _DateTimeExtension on DateTime {
  String toShortString() => '${day.toPadLeftZero()}/${month.toPadLeftZero()}/${year - 2000} ${hour.toPadLeftZero()}:${minute.toPadLeftZero()}';
}

extension _IntExtension on int {
  String toPadLeftZero() => toString().padLeft(2, '0');
}
