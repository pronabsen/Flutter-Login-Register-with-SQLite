
import 'dart:convert';

UserModel usersFromJson(String str) {
  final jsonData = json.decode(str);
  return UserModel.fromMap(jsonData);
}

String usersToJson(UserModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class UserModel {
  late int id;
  late String name;
  late String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
  };

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email}';
  }
}