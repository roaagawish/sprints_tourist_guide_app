import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/functions.dart';
import '../01_auth_screens/bloc/auth_bloc.dart';
import '../01_auth_screens/widgets/text_form_field.dart';
import '../resourses/colors_manager.dart';
import '../resourses/styles_manager.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullnameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final authEntity = context.read<AuthBloc>().authObj!;
    _fullnameController = TextEditingController(text: authEntity.name);
    _emailController = TextEditingController(text: authEntity.email);
    _phoneController = TextEditingController(text: authEntity.phone);
  }

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          context.tr('editUser.title'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16.0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr("editUser.personalDetails"),
                style: Styles.style24Bold(),
              ),
              const SizedBox(height: 30),
              // Full name field
              CustomTextFormField(
                controller: _fullnameController,
                labelText: tr("signup.fullNameLabel"),
                prefixIcon: const Icon(Icons.person),
                inputType: TextInputType.name,
              ),
              CustomTextFormField(
                controller: _emailController,
                labelText: tr("signup.emailLabel"),
                prefixIcon: const Icon(Icons.alternate_email),
                inputType: TextInputType.emailAddress,
                enabled: false,
              ),
              CustomTextFormField(
                controller: _phoneController,
                labelText: tr("signup.phoneLabel"),
                prefixIcon: const Icon(Icons.phone),
                inputType: TextInputType.phone,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is UpdateInfoSuccess) {
                    Navigator.of(context).pop();
                  }
                  if (state is UpdateInfoFailure) {
                    showToast(state.errMessage, ColorsManager.softRed);
                  }
                },
                builder: (context, state) {
                  if (state is UpdateInfoLoading) {
                    return ElevatedButton(
                        onPressed: null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            Text(tr("editUser.submit")),
                            CircularProgressIndicator(
                              color: ColorsManager.white,
                              strokeAlign:
                                  CircularProgressIndicator.strokeAlignInside,
                            ),
                          ],
                        ));
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(UpdateInfoRequested(
                              fullName: _fullnameController.text,
                              phone: _phoneController.text,
                            ));
                      }
                    },
                    child: Text(
                      context.tr('editUser.submit'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
