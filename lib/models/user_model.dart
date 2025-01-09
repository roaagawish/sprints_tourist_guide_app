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
    if (users.any((user) => (user.email == email && user.password == password))) {
      // check if the email is right
      if (users.any((user) => (user.email != email))) {
        return "Wrong email";
      } // check if the password is right 
      else if (users.any((user) => (user.password != password))) {
        return "Wrong password";
      }
      return "User Loged in Successfully!";
    } else {
      return "Account not found! Try registering first" ;
    }
  }
}
