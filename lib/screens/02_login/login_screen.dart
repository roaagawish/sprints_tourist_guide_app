import 'package:flutter/material.dart';
import 'widgets/locale_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.tr('loginPageTitle')),
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
                // Sign In button
                ElevatedButton(
                  onPressed: () {
                    var validationResult = _formKey.currentState!.validate();
                    if (!validationResult) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(context.tr('signInValidationFailureMessage'))),
                      );
                      return;
                    }

                    // place sign-in query here

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text(context.tr('signInSuccessMessage')),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    widget.signInSuccessfulCallback?.call();
                                  },
                                  child: Text(
                                      context.tr('close'))),
                            ],
                          );
                        });
                  },
                  child: Text(context.tr('login')),
                ),
              ],
            )),
      ),
    );
  }
}
