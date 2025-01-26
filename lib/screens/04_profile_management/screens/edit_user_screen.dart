import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/user_model.dart';
import '../blocs/profile_bloc.dart';

class EditUserScreen extends StatelessWidget {
  final UserModel userData;
  final Future<bool> Function(UserModel)? editUserData;
  final void Function()? onDone;

  final _formKey = GlobalKey<FormState>();
  late final _fullnameController = TextEditingController(text: userData.fullName);
  late final _emailController = TextEditingController(text: userData.email);
  late final _phoneController = TextEditingController(text: userData.phone);

  EditUserScreen(
      {super.key, required this.userData, this.editUserData, this.onDone});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Edit User screen',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blueGrey,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Personal Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Full Name'),
                        controller: _fullnameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full Name may not be empty!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        controller: _emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Phone'),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Updated successfully'),
                                ),
                              );
                              onDone?.call();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to update!'),
                                ),
                              );
                            }
                          });
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
