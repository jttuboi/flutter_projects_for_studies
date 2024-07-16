// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  User({
    required this.id,
    required this.username,
    required this.photoUrl,
    required this.active,
    required this.lastseen,
  });

  String? id;
  final String username;
  final String photoUrl;
  final bool active;
  final DateTime lastseen;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'photoUrl': photoUrl,
      'active': active,
      'lastseen': lastseen.toIso8601String(),
    };
  }

  static User? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) return null;

    return User(
      id: map['id'] as String,
      username: map['username'] as String,
      photoUrl: map['photoUrl'] as String,
      active: map['active'] as bool,
      lastseen: DateTime.parse(map['lastseen'] as String),
    );
  }
}
