class UserModel {
  static const String collectionName = "User";
  String? id;
  String? email;
  String? name;
  String? password;

  UserModel({this.id, this.name, this.email, this.password});

  UserModel.fromFireStore(Map<String, dynamic> json)
      : this(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            password: json["password"]);

  Map<String, dynamic> toFireStore() {
    return {"id": id, "name": name, "email": email, "password": password};
  }
}
