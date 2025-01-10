import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('login Screen'),
      ),
    );
  }

    void Login() async{
    String message = await LocalDataBase.Login(
        email: _emailController.text,
        password: _passwordController.text,
    );
    switch (message) {
      case "Wrong password! Please Try Again.":
      case "Account not found! Try registering first":
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 20,
            backgroundColor: ColorsManager.softRed,
            textColor: ColorsManager.white,
            fontSize: 16.0);
        break;
      case "Loged in Successfully!":
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 20,
            backgroundColor: ColorsManager.oliveGreen,
            textColor: ColorsManager.white,
            fontSize: 16.0);
             Navigator.of(context).pushReplacementNamed(
              Routes.homeRoute,
            );
        break;
      default:
          Fluttertoast.showToast(
      msg: "An unexpected error occurred.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      backgroundColor: ColorsManager.softRed,
      textColor: ColorsManager.white,
      fontSize: 16.0,
    );
    }
  }
}
