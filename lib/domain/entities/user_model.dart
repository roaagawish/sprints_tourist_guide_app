class UserModel {
  final String fullName;
  final String email;
  final String? phone;
  final String password;

  UserModel(
      {required this.fullName,
      required this.email,
      required this.password,
      this.phone});

// Convert a UserModel to a Map for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  // Create a UserModel from a Map (for JSON deserialization)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }
}
