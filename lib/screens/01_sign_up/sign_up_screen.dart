import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('SignUp Screen'),
      ),
    );
  }

  void SignUp() {
    String message = LocalDataBase.SignUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        phone: _phoneController.text);

    switch (message) {
      case "This email is alerady registerd!":
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 20,
            backgroundColor: ColorsManager.red,
            textColor: ColorsManager.white,
            fontSize: 16.0);
        break;
      case "User added Successfully!":
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 20,
            backgroundColor: ColorsManager.oliveGreen,
            textColor: ColorsManager.white,
            fontSize: 16.0);
              Navigator.of(context).pushNamed(
              Routes.loginRoute,
            );
        break;
      default:
    }
  }
}
