class User {
  User({
    required this.id,
    required this.username,
    required this.photoUrl,
    required this.active,
    required this.lastSeen,
  });

  String? id;
  final String username;
  final String photoUrl;
  final bool active;
  final DateTime lastSeen;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'photo_url': photoUrl,
      'active': active,
      'last_seen': lastSeen.toIso8601String(),
    };
  }

  static User? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      photoUrl: map['photo_url'] as String,
      active: map['active'] as bool,
      lastSeen: DateTime.parse(map['last_seen'] as String),
    );
  }
}
