import 'package:flutter/material.dart';
import '../../../app/di.dart';
import '../../../app/type_definitions.dart';
import '../../../app/validation_service.dart';
import '../../resourses/styles_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final bool isPasswordField;
  final ValidatorFunction? validator;
  final TextInputType inputType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.isPasswordField = false,
    this.validator,
    required this.inputType,
  });

  static final validationService = instance<IValidationService>();

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  ValidatorFunction get _defaultValidator {
    switch (widget.inputType) {
      case TextInputType.name:
        return CustomTextFormField.validationService.validateName;
      case TextInputType.visiblePassword:
        return CustomTextFormField.validationService.validatePassword;
      case TextInputType.emailAddress:
        return CustomTextFormField.validationService.validateEmail;
      case TextInputType.phone:
        return CustomTextFormField.validationService.validatePhone;
      default:
        return CustomTextFormField.validationService.validateNotEmpty;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPasswordField ? _obscureText : false,
      obscuringCharacter: widget.isPasswordField ? "*" : " ",
      style: Styles.style16Medium(),
      decoration: InputDecoration(
        labelText: widget.labelText,
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
      validator: widget.validator ?? _defaultValidator,
      keyboardType: widget.inputType,
    );
  }
}
