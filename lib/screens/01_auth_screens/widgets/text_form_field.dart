import 'package:flutter/material.dart';
import '../../../resourses/colors_manager.dart';
import '../../../resourses/styles_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final bool isPasswordField;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.isPasswordField = false,
    required this.validator,
    required this.keyboardType,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  TextStyle testFieldStyle =
      Styles.style14Medium().copyWith(fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? _obscureText : false,
      obscuringCharacter: widget.isPasswordField ? "*" : " ",
      decoration: InputDecoration(
        hoverColor: ColorsManager.mediumGreen,
        focusColor: ColorsManager.mediumGreen,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: ColorsManager.darkGreen),
        ),
        labelText: widget.labelText,
        labelStyle: testFieldStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: _obscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : null,
      ),
      validator: widget.validator,
      keyboardType: widget.keyboardType,
    );
  }
}
