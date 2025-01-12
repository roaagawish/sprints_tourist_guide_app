import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/local_database.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import 'widgets/flutter_toast.dart';
import 'widgets/locale_dropdown.dart';
import 'widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr("signup.fullNameEmptyMessage");
    }
    final regex = RegExp('^[A-Z]');
    if (!regex.hasMatch(value)) {
      return tr("signup.fullNameCapitalizedMessage");
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length < 11) {
      return tr("signup.phoneEmptyMessage");
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr("signup.emailAddressEmptyMessage");
    }
    var valid = value.contains('@');
    if (!valid) {
      return tr("signup.emailAddressInvalidMessage");
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr("signup.passwordEmptyMessage");
    }
    if (value.length < 6) {
      return tr("signup.passwordTooShortMessage");
    }
    return null;
  }

  String? confirmPasswordValidator(String? value) {
    if (_passwordController.text != value) {
      return tr("signup.confirmPasswordValidationMessage");
    }
    return null;
  }

  void signUp() async {
    String message = await LocalDataBase.signUp(
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
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(
            Routes.loginRoute,
          );
        }
        break;
      default:
        showToast(
          (context.locale.languageCode == "ar"
              ? "خطأ غير متوقع"
              : "An unexpected error occurred"),
          ColorsManager.softRed,
        );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _emailAddressController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: LocaleDropdown(),
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
                    Align(
                      alignment: context.locale.languageCode == "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        tr("signup.signUp"),
                        style: Styles.style24Bold().copyWith(fontSize: 35),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Full name field
                    CustomTextFormField(
                      controller: _fullNameController,
                      labelText: tr("signup.fullNameLabel"),
                      prefixIcon: const Icon(Icons.person),
                      keyboardType: TextInputType.name,
                      validator: nameValidator,
                    ),
                    const SizedBox(height: 15),
                    // Phone Number field
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: tr("signup.phoneLabel"),
                      prefixIcon: const Icon(Icons.phone),
                      keyboardType: TextInputType.phone,
                      validator: phoneValidator,
                    ),
                    const SizedBox(height: 15),
                    // Email field
                    CustomTextFormField(
                      controller: _emailAddressController,
                      labelText: tr("signup.emailLabel"),
                      prefixIcon: const Icon(Icons.alternate_email),
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 15),
                    // Password field
                    CustomTextFormField(
                      isPasswordField: true,
                      controller: _passwordController,
                      labelText: tr("signup.passwordLabel"),
                      prefixIcon: const Icon(Icons.lock_open),
                      keyboardType: TextInputType.text,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 15),
                    // Confirm password field
                    CustomTextFormField(
                      isPasswordField: true,
                      controller: _confirmPasswordController,
                      labelText: tr("signup.confirmPasswordLabel"),
                      prefixIcon: const Icon(Icons.lock_open),
                      keyboardType: TextInputType.text,
                      validator: confirmPasswordValidator,
                    ),
                    SizedBox(height: 30),
                    // Sign Up button
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUp();
                        }
                      },
                      child: Text(tr("signup.signUpButton")),
                    ),
                    SizedBox(height: 15),
                    // already-have-an-account button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.loginRoute);
                      },
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: tr("signup.alreadyHaveAnAccount"),
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
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
