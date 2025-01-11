import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'widgets/flutter_toast.dart';
import 'widgets/locale_dropdown.dart';
import 'widgets/text_form_field.dart';

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
                      alignment:context.locale.languageCode == "ar" ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        tr("login.login"),
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
                          return tr("login.emailAddressEmptyMessage");
                        }
                        var valid = emailAddress.contains('@');
                        if (!valid) {
                          return tr("login.emailAddressInvalidMessage");
                        }
                        return null;
                      },
                      controller: _emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      labelText:  tr("login.emailLabel"),
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
                          return tr("login.passwordEmptyMessage");
                        }

                        if (password.length < 6) {
                          return tr("login.passwordTooShortMessage");
                        }

                        return null;
                      },
                      controller: _passwordController,
                      labelText:  tr("login.passwordLabel"),
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
                      child: Text(tr("login.loginButton")),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // don't-have-an-account button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.signUpRoute,
                        );
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: tr("login.donotHaveAccount"),
                              style: Styles.style12Medium(),
                            ),
                            TextSpan(
                              text: tr("login.registerNow"),
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
      case "Wrong password! Please try again":
      case "كلمة المرور خاطئة! يرجى المحاولة مرة أخرى":
      case "Account not found! Try registering first":
      case  "الحساب غير موجود! يرجى التسجيل أولاً":
        showToast(message, ColorsManager.red);
        break;
      case "Logged in Successfully!":
      case  "تم تسجيل الدخول بنجاح!":
        showToast(message, ColorsManager.oliveGreen);
        Navigator.of(context).pushReplacementNamed(
          Routes.homeRoute,
        );
        break;
      default:
        showToast( (context.locale.languageCode == "ar" ? "خطأ غير متوقع" : "An unexpected error occurred"), ColorsManager.softRed,
        );
    }
  }
}
