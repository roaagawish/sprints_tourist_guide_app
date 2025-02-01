import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../entities/otp_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SendPhoneOtpUsecase implements BaseUseCase<String, OtpEntity> {
  final Repository _repository;

  SendPhoneOtpUsecase(this._repository);

  @override
  Future<Either<Failure, OtpEntity>> execute([String? input]) async {
    //we can handle some permesions here in each usecase before execute the repo methods.
    return await _repository.sendOtpToNewPhoneNumber(input!);
  }
}
