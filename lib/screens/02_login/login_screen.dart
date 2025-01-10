import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String languageCode, String? countryCode)? localeChangeCallback;
  final void Function()? signInSuccessfulCallback;
  const LoginScreen(
      {super.key, this.localeChangeCallback, this.signInSuccessfulCallback});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _hidePassword = true;
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        email: _emailAddressController.text,
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
            backgroundColor: ColorsManager.red,
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
    }
  }
}
