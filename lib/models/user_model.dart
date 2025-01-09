class UserModel {
  final String name;
  final String email;
  final String? phone;
  final String password;

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      this.phone});
}

class LocalDataBase {
  static List<UserModel> users = [];

// sign up and add new user to database
  static String SignUp( 
      {String? phone, required String name, required String email, required String password}) {
    //check if user already exists
    if (users.any((user) => user.email == email)) {
      return "This email is alerady registerd!";
    }
    // add user
    users.add(UserModel(name: name, email: email, password: password));
    return "User added Successfully!";
  }

// login to already registerd user
  static String Login({required String email, required String password}) {
    //check if user already exists
   for (var user in users) {
      if (user.email == email) {
         // check if the password is right 
      if (user.password == password) {
        return "Logged in Successfully!";
      } else {
      return "Wrong password! Please Try Again.";
    } } }
    // if the email doesnot match any of the database items
    return "Account not found! Try registering first" ;
}
}
