import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/otp_entity.dart';
import 'text_form_field.dart';

class VerifyPhoneOTPBottomSheet extends StatefulWidget {
  final OtpEntity otpEntity;
  const VerifyPhoneOTPBottomSheet({super.key, required this.otpEntity});

  @override
  State<VerifyPhoneOTPBottomSheet> createState() =>
      _VerifyPhoneOTPBottomSheetState();
}

class _VerifyPhoneOTPBottomSheetState extends State<VerifyPhoneOTPBottomSheet> {
  final TextEditingController _controller1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20.0,
        children: [
          CustomTextFormField(
            controller: _controller1,
            labelText: tr("enter_otp_number"),
            prefixIcon: const Icon(Icons.security),
            inputType: null,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("verify_otp").tr(),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
