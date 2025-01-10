import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import '../01_sign_up/widgets/flutter_toast.dart';
import '../01_sign_up/widgets/text_form_field.dart';
import 'widgets/locale_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  final void Function(String languageCode, String? countryCode)?
      localeChangeCallback;
  final void Function()? signInSuccessfulCallback;
  const LoginScreen(
      {super.key, this.localeChangeCallback, this.signInSuccessfulCallback});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: LocaleDropdown(
              // dropdown menu to set app locale
              callback: widget.localeChangeCallback,
            ),
          ),
        ],
      ),
      body: Center(
        child: Form(
            // the user input form
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome Back!',
                        style: Styles.style24Bold().copyWith(fontSize: 35),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Email field
                    CustomTextFormField(
                      validator: (String? emailAddress) {
                        if (emailAddress == null || emailAddress.isEmpty) {
                          return context.tr('emailAddressEmptyMessage');
                        }
                        var valid = emailAddress.contains('@');
                        if (!valid) {
                          return context.tr('emailAddressInvalidMessage');
                        }
                        return null;
                      },
                      controller: _emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.alternate_email),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Password field
                    CustomTextFormField(
                      isPasswordField: true,
                      keyboardType: TextInputType.text,
                      validator: (String? password) {
                        if (password == null || password.isEmpty) {
                          return context.tr('passwordEmptyMessage');
                        }

                        if (password.length < 6) {
                          return context.tr('passwordTooShortMessage');
                        }

                        return null;
                      },
                      controller: _passwordController,
                      labelText: "Password",
                      //labelStyle: ,
                      prefixIcon: const Icon(Icons.lock_open),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    // Login button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Login();
                        }
                      },
                      child: Text(context.tr('Login')),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // don't-have-an-account button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          Routes.signUpRoute,
                        );
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Don\'t  Have an Account? ',
                              style: Styles.style12Medium(),
                            ),
                            TextSpan(
                              text: 'Register Now',
                              style: Styles.style14Medium()
                                  .copyWith(color: ColorsManager.darkGreen),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  void Login() async {
    String message = await LocalDataBase.Login(
      email: _emailAddressController.text,
      password: _passwordController.text,
    );
    switch (message) {
      case "Wrong password! Please try again.":
      case "Account not found! Try registering first.":
        showToast(message, ColorsManager.red);
        break;
      case "Logged in Successfully!":
        showToast(message, ColorsManager.white);
        Navigator.of(context).pushReplacementNamed(
          Routes.homeRoute,
        );
        break;
      default:
        showToast( "An unexpected error occurred.",ColorsManager.softRed);
    }
  }
}
