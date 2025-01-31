import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/functions.dart';
import '../resourses/colors_manager.dart';
import '../resourses/language_manager.dart';
import '../resourses/routes_manager.dart';
import '../resourses/styles_manager.dart';
import '../02_home/widgets/language_toggle_switch.dart';
import '../02_home/widgets/theme_toggle_switch.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/text_form_field.dart';
import 'widgets/clickable_text_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailAddressController.dispose();
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
                          tr("login.login"),
                          style: Styles.style35Bold().copyWith(
                              color: isLightTheme(context)
                                  ? ColorsManager.darkGreen
                                  : ColorsManager.lightOrange),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email field
                      CustomTextFormField(
                        controller: _emailAddressController,
                        labelText: tr("signup.emailLabel"),
                        prefixIcon: const Icon(Icons.alternate_email),
                        inputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      // Password field
                      CustomTextFormField(
                        isPasswordField: true,
                        controller: _passwordController,
                        labelText: tr("signup.passwordLabel"),
                        prefixIcon: const Icon(Icons.lock_open),
                        inputType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 30),
                      // Login button
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginSuccess) {
                            Navigator.of(context).pushReplacementNamed(
                              Routes.homeRoute,
                            );
                          }
                          if (state is LoginFailure) {
                            showToast(state.errMessage, ColorsManager.softRed);
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return ElevatedButton(
                                onPressed: null,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 10,
                                  children: [
                                    Text(tr("login.loginButton")),
                                    CircularProgressIndicator(
                                      color: ColorsManager.white,
                                      strokeAlign: CircularProgressIndicator
                                          .strokeAlignInside,
                                    ),
                                  ],
                                ));
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(LoginRequested(
                                    email: _emailAddressController.text,
                                    password: _passwordController.text));
                              }
                            },
                            child: Text(tr("login.loginButton")),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      ClickableTextRow(
                        firstLabel: tr("login.donotHaveAccount"),
                        secondLabel: tr("login.registerNow"),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            Routes.signUpRoute,
                          );
                        },
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
