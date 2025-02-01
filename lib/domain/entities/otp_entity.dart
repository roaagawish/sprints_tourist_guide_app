class OtpEntity {
  final String verificationId;
  final int? resendToken;

  OtpEntity({
    required this.verificationId,
    this.resendToken,
  });
}
