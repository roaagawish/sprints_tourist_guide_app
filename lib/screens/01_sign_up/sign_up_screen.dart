import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/flutter_toast.dart';
import 'widgets/locale_dropdown.dart';
import 'widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  final void Function(String languageCode, String? coutnryCode)?
      localeChangeCallback;
  final void Function()? signUpSuccessfulCallback;
  final void Function()? alreadyHaveAnAccountCallback;

  const SignUpScreen(
      {super.key,
      this.localeChangeCallback,
      this.signUpSuccessfulCallback,
      this.alreadyHaveAnAccountCallback});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
                        'Sign Up',
                        style: Styles.style24Bold().copyWith(fontSize: 35),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Full name field
                    CustomTextFormField(
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
                      labelText: "Full Name",
                      prefixIcon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Phone Number field
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: "Phone Number",
                      prefixIcon: const Icon(Icons.phone),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        // if (value != null && value.length < 11) {
                        //   return " Phone Number must be 11 digit";
                        // }
                        // return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
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
                      labelText: "Email Address",
                      prefixIcon: const Icon(Icons.alternate_email),
                      keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(
                      height: 15,
                    ),
                    // Confirm password field
                    CustomTextFormField(
                      isPasswordField: true,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (_passwordController.text != value) {
                          return context.tr('confirmPasswordValidationMessage');
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock_open),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Sign Up button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SignUp();
                        }
                      },
                      child: Text(context.tr('signUp')),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // already-have-an-account button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.loginRoute);
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: 'Arealdy Have an Account? ',
                              style: Styles.style12Medium(),
                            ),
                            TextSpan(
                              text: 'Login In',
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

  void SignUp() async {
    String message = await LocalDataBase.SignUp(
        fullName: _fullNameController.text,
        email: _emailAddressController.text,
        password: _passwordController.text,
        phone: _phoneController.text);

    switch (message) {
      case "This email is already registered!":
        showToast(message, ColorsManager.softRed);
        break;
      case "User added successfully!":
        showToast(message, ColorsManager.oliveGreen);
        Navigator.of(context).pushNamed(
          Routes.loginRoute,
        );
        break;
      default:
        showToast("An unexpected error occurred.", ColorsManager.softRed,
        );
    }
  }
}
