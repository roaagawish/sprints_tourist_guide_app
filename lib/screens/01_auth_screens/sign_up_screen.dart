import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/functions.dart';
import '../../resourses/colors_manager.dart';
import '../../resourses/language_manager.dart';
import '../../resourses/routes_manager.dart';
import '../../resourses/styles_manager.dart';
import '../02_home/widgets/language_toggle_switch.dart';
import '../02_home/widgets/theme_toggle_switch.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/clickable_text_row.dart';
import 'widgets/flutter_toast.dart';
import 'widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  final void Function()? onSignUpSuccessful;
  const SignUpScreen({
    super.key,
    this.onSignUpSuccessful,
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
    return SafeArea(
      child: Scaffold(
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
                        alignment: LocalizationUtils.isCurrentLocalAr(context)
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          tr("signup.signUp"),
                          style: Styles.style35Bold().copyWith(
                              color: isLightTheme(context)
                                  ? ColorsManager.darkGreen
                                  : ColorsManager.lightOrange),
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
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            showToast(state.message, ColorsManager.oliveGreen);
                            if (mounted) {
                              Navigator.of(context).pushReplacementNamed(
                                Routes.loginRoute,
                              );
                            }
                          }
                          if (state is RegisterFailure) {
                            showToast(state.errMessage, ColorsManager.softRed);
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state.loading == true
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthBloc>().add(
                                          RegisterRequested(
                                              email:
                                                  _emailAddressController.text,
                                              password:
                                                  _passwordController.text,
                                              fullName:
                                                  _fullNameController.text,
                                              phone: _phoneController.text));
                                    }
                                  },
                            child: state.loading == true
                                ? CircularProgressIndicator(
                                    color: ColorsManager.white,
                                    strokeAlign: CircularProgressIndicator
                                        .strokeAlignInside,
                                  )
                                : Text(tr("signup.signUpButton")),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      ClickableTextRow(
                        firstLabel: tr("signup.alreadyHaveAnAccount"),
                        secondLabel: tr("signup.goToLoginPage"),
                      ),
                      SizedBox(height: 10),
                      LanguageToggleSwitch(),
                      SizedBox(height: 10),
                      ThemeToggleSwitch(),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
