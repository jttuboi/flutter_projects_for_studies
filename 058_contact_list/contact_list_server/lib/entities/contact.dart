import 'package:equatable/equatable.dart';

import 'sync_status.dart';

class Contact with EquatableMixin {
  const Contact({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.documentUrl,
    this.createdAt,
    this.updatedAt,
    this.syncStatus = SyncStatus.synced,
  });

  const Contact.noData()
      : id = '',
        name = '',
        avatarUrl = '',
        documentUrl = '',
        createdAt = null,
        updatedAt = null,
        syncStatus = SyncStatus.synced;

  final String id;
  final String name;
  final String avatarUrl;
  final String documentUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SyncStatus syncStatus;

  @override
  List<Object?> get props => [id, name, avatarUrl, documentUrl, createdAt, updatedAt, syncStatus];

  @override
  bool? get stringify => true;

  static const tableName = 'contact';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnAvatarUrl = 'avatar_url';
  static const columnDocumentUrl = 'document_url';
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
    DateTime? createdAt,
    DateTime? updatedAt,
    SyncStatus? syncStatus,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      documentUrl: documentUrl ?? this.documentUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }

  @override
  String toString() {
    return 'Contact('
        'id: $id, '
        'name: $name, '
        'avatarUrl: $avatarUrl, '
        'documentUrl: $documentUrl, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'syncStatus: $syncStatus'
        ')';
  }

  String toShortString() {
    return 'Contact('
        'id: ...${id.substring(id.length - 4)}, '
        'name: $name, '
        'aUrl: ${avatarUrl.split('/').last}, '
        'dUrl: ${documentUrl.split('/').last}, '
        'crAt: ${createdAt?.toShortString()}, '
        'upAt: ${updatedAt?.toShortString()}, '
        'sySt: ${syncStatus.name}, '
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
      createdAt: DateTime.tryParse(map[Contact.columnCreatedAt] ?? ''),
      updatedAt: DateTime.tryParse(map[Contact.columnUpdatedAt] ?? ''),
      syncStatus: SyncStatus.fromString(map[Contact.columnSyncStatus]),
    );
  }

  Map<String, dynamic> toEntityMap() {
    return {
      'entity': toMap(),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      Contact.columnId: id,
      Contact.columnName: name,
      Contact.columnAvatarUrl: avatarUrl,
      Contact.columnDocumentUrl: documentUrl,
      Contact.columnCreatedAt: createdAt?.toIso8601String(),
      Contact.columnUpdatedAt: updatedAt?.toIso8601String(),
      Contact.columnSyncStatus: syncStatus.name,
    };
  }
}

extension _DateTimeExtension on DateTime {
  String toShortString() => '${day.toPadLeftZero()}/${month.toPadLeftZero()}/${year - 2000} ${hour.toPadLeftZero()}:${minute.toPadLeftZero()}';
}

extension _IntExtension on int {
  String toPadLeftZero() => toString().padLeft(2, '0');
}

extension ContactsExtension on List<Contact> {
  static List<Contact> fromEntitiesMap(Map<String, dynamic> map) {
    final maps = map['entities'] as List;

    return maps.map<Contact>((map) => ContactExtension.fromMap(map)).toList();
  }

  Map<String, dynamic> toEntitiesMap() {
    return {
      'entities': map<Map<String, dynamic>>((contact) => contact.toMap()).toList(),
    };
  }

  Map<String, dynamic> toCountMap() {
    return {
      'count': length,
    };
  }
}
