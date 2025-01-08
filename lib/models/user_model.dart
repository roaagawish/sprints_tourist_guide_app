class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String password;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.phone});
}


class LocalDataBase {

  static List<UserModel> users = [];
}