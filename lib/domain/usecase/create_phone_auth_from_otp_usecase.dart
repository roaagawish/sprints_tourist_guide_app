import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class CreatePhoneAuthFromOtpUsecase
    implements BaseUseCase<CreatePhoneAuthFromOtpInput, PhoneAuthCredential> {
  final Repository _repository;
  CreatePhoneAuthFromOtpUsecase(this._repository);

  @override
  Future<Either<Failure, PhoneAuthCredential>> execute(
      [CreatePhoneAuthFromOtpInput? input]) async {
    return _repository.createPhoneAuthCredentialWithOtp(
        PhoneAuthCredentialRequest(input!.verificationId, input.smsCode));
  }
}

class CreatePhoneAuthFromOtpInput {
  String verificationId;
  String smsCode;
  CreatePhoneAuthFromOtpInput(
    this.verificationId,
    this.smsCode,
  );
}
