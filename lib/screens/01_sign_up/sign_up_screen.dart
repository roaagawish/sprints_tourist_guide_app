import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import '../02_login/widgets/flutter_toast.dart';
import '../02_login/widgets/locale_dropdown.dart';
import '../02_login/widgets/text_form_field.dart';

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
                      alignment:context.locale.languageCode == "ar" ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(tr("signup.signUp"),
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
                          return tr("signup.fullNameEmptyMessage");
                        }
                        final regex = RegExp('^[A-Z]');
                        if (!regex.hasMatch(fullName)) {
                          return tr("signup.fullNameCapitalizedMessage");
                        }
                        return null;
                      },
                      controller: _fullNameController,
                      labelText:tr("signup.fullNameLabel"),
                      prefixIcon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Phone Number field
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: tr("signup.phoneLabel"),
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
                          return tr("signup.emailAddressEmptyMessage");
                        }
                        var valid = emailAddress.contains('@');
                        if (!valid) {
                          return tr("signup.emailAddressInvalidMessage");
                        }
                        return null;
                      },
                      controller: _emailAddressController,
                      labelText: tr("signup.emailLabel"),
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
                          return tr("signup.passwordEmptyMessage");
                        }

                        if (password.length < 6) {
                          return tr("signup.passwordTooShortMessage");
                        }

                        return null;
                      },
                      controller: _passwordController,

                      labelText: tr("signup.passwordLabel"),
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
                          return tr("signup.confirmPasswordValidationMessage");
                        }
                        return null;
                      },
                      controller: _confirmPasswordController,
                      labelText: tr("signup.confirmPasswordLabel"),
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
                      child: Text(tr("signup.signUpButton")),
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
                              text:tr("signup.alreadyHaveAnAccount"),
                              style: Styles.style12Medium(),
                            ),
                            TextSpan(
                              text: tr("signup.goToLoginPage"),
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
      case "هذا البريد الإلكتروني مسجل بالفعل!":
        showToast(message, ColorsManager.softRed);
        break;
      case "User added successfully!":
      case "تم إضافة المستخدم بنجاح!":
        showToast(message, ColorsManager.oliveGreen);
        Navigator.of(context).pushNamed(
          Routes.loginRoute,
        );
        break;
      default:
        showToast( (context.locale.languageCode == "ar" ? "خطأ غير متوقع" : "An unexpected error occurred"), ColorsManager.softRed,
        );
    }
  }
}
