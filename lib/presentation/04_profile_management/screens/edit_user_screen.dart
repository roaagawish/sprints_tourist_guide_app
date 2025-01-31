import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/user_model.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel userData;
  final Future<bool> Function(UserModel)? editUserData;
  final void Function()? onDone;

  final _formKey = GlobalKey<FormState>();
  late final _fullnameController =
      TextEditingController(text: userData.fullName);
  late final _emailController = TextEditingController(text: userData.email);
  late final _phoneController = TextEditingController(text: userData.phone);

  EditUserScreen(
      {super.key, required this.userData, this.editUserData, this.onDone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr('editUser.title'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                spacing: 16.0,
                children: [
                  Text(
                    context.tr("editUser.personalDetails"),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: context.tr('editUser.fullName')),
                    controller: _fullnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.tr('editUser.fullNameEmpty');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: context.tr('editUser.email')),
                    controller: _emailController,
                    enabled: false,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: context.tr('editUser.phone')),
                    controller: _phoneController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      UserModel updatedUserData = UserModel(
                          fullName: _fullnameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          password: userData.password);

                      editUserData?.call(updatedUserData).then((value) {
                        if (value) {
                          onDone?.call();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(context.tr('editUser.failedToUpdate')),
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      context.tr('editUser.submit'),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
