import 'package:flutter/material.dart';
import 'widgets/locale_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';

// the sign-up page widget
class SignUpScreen extends StatefulWidget {
  final void Function(String languageCode, String? coutnryCode)? localeChangeCallback;
  final void Function()? signUpSuccessfulCallback;
  final void Function()? alreadyHaveAnAccountCallback;

  const SignUpScreen(
      {super.key, this.localeChangeCallback, this.signUpSuccessfulCallback, this.alreadyHaveAnAccountCallback});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _hidePassword = true;
  var _hideConfirmPassword = true;
  final _fullNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('signUpPageTitle')),
        actions: [
          LocaleDropdown(
            // dropdown menu to set app locale
            callback: widget.localeChangeCallback,
          ),
          SizedBox(
            // dummy padding box
            width: 20,
          )
        ],
      ),
      body: Center(
        child: Form(
            // the user input form
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Full name field
                TextFormField(
                  validator: (String? fullName) {
                    if (fullName == null || fullName.isEmpty) {
                      return context.tr('fullNameEmptyMessage');
                    }
                    final regex = RegExp('^[A-Z]');
                    if (!regex.hasMatch(fullName)) {
                      return context.tr('fullNameCapitalizedMessage');
                    }
                    return null;
                  },
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    hintText: context.tr('fullNameHint'),
                  ),
                ),
                // Email field
                TextFormField(
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
                  decoration: InputDecoration(
                    hintText: context.tr('emailHint'),
                  ),
                ),
                // Password field
                TextFormField(
                  obscureText: _hidePassword,
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
                  decoration: InputDecoration(
                      hintText: context.tr('passwordHint'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: Icon(_hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
                // Confirm password field
                TextFormField(
                  obscureText: _hideConfirmPassword,
                  validator: (value) {
                    if (_passwordController.text != value) {
                      return context.tr('confirmPasswordValidationMessage');
                    }
                    return null;
                  },
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      hintText:
                          context.tr('confirmPasswordHint'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hideConfirmPassword = !_hideConfirmPassword;
                            });
                          },
                          icon: Icon(_hideConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    var validationResult = _formKey.currentState!.validate();
                    if (!validationResult) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(context.tr('signUpValidationFailureMessage'))),
                      );
                      return;
                    }

                    // place sign-up query here

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(context.tr('signUpSuccessMessage')),
                            actions: [
                              TextButton(
                                  onPressed: widget.signUpSuccessfulCallback,
                                  child: Text(
                                      context.tr('close'))),
                            ],
                          );
                        });
                  },
                  child: Text(context.tr('signUp')),
                ),
                // already-have-an-account button
                ElevatedButton(
                  onPressed: widget.alreadyHaveAnAccountCallback,
                  child: Text(context.tr('alreadyHaveAnAccount')),
                ),
              ],
            )),
      ),
    );
  }
}
