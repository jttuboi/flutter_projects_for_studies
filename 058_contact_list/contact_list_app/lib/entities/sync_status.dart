enum SyncStatus {
  synced,
  added,
  updated,
  removed,
  ;

  bool get isSynced => this == SyncStatus.synced;

  bool get isAdded => this == SyncStatus.added;

  bool get isUpdated => this == SyncStatus.updated;

  bool get isRemoved => this == SyncStatus.removed;
}

extension SyncStatusExtension on SyncStatus {
  static SyncStatus fromString(String syncStatus) {
    if (SyncStatus.synced.name == syncStatus) {
      return SyncStatus.synced;
    } else if (SyncStatus.added.name == syncStatus) {
      return SyncStatus.added;
    } else if (SyncStatus.updated.name == syncStatus) {
      return SyncStatus.updated;
    } else if (SyncStatus.removed.name == syncStatus) {
      return SyncStatus.removed;
    }
    return SyncStatus.synced;
  }
}
