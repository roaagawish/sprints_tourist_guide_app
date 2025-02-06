import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../domain/entities/auth_entity.dart';
import '../domain/entities/otp_entity.dart';
import '../presentation/01_auth_screens/widgets/choose_camera_or_gallery.dart';
import '../presentation/01_auth_screens/widgets/verify_phone_otp.dart';
import '../presentation/02_home/blocs/theme_bloc/theme_bloc.dart';
import '../presentation/resourses/colors_manager.dart';
import '../presentation/resourses/constant_manager.dart';

Future<void> hiveBoxes() async {
  await Hive.openBox<AuthenticationEntity>(AppConstants.kUserDataBox);
}

void hiveAdapters() {
  Hive.registerAdapter(AuthenticationEntityAdapter());
}

bool isLightTheme(BuildContext context) {
  return context.read<ThemeBloc>().state.themeMode == ThemeMode.light;
}

void showToast(String message, Color color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 20,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<ImageSource?> showImageSourceBottomSheet(
  BuildContext context,
) async {
  return await showModalBottomSheet<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return ChooseCameraOrGallery();
    },
  );
}

Future<void> verifyPhoneOtpbottomSheet(
    BuildContext context, OtpEntity otpEntity) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: ColorsManager.goldenSand,
    barrierColor: ColorsManager.black.withValues(alpha: 0.7),
    isScrollControlled: true,
    builder: (context) {
      return VerifyPhoneOTPBottomSheet(otpEntity: otpEntity);
    },
  );
}
