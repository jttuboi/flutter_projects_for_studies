// representa um modelo de dados que veio da base de dados/api
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
    required this.role,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    name = json['name'] as String;
    email = json['email'] as String;
    picture = json['picture'] as String;
    role = json['role'] as String;
    token = json['token'] as String;
  }

  late String id;
  late String name;
  late String email;
  late String picture;
  late String role;
  late String token;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['picture'] = picture;
    data['role'] = role;
    data['token'] = token;
    return data;
  }

  @override
  String toString() {
    return 'id=$id name=$name email=$email picture=$picture role=$role token=$token';
  }
}
