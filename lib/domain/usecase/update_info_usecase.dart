import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../../data/network/requests.dart';
import '../entities/auth_entity.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class UpdateInfoUsecase
    implements BaseUseCase<UpdateInfoCaseInput, AuthenticationEntity> {
  final Repository _repository;

  UpdateInfoUsecase(this._repository);

  @override
  Future<Either<Failure, AuthenticationEntity>> execute(
      [UpdateInfoCaseInput? input]) async {
    //we can handle some permesions here in each usecase before execute the repo methods.
    return await _repository.updateInfo(UpdateInfoRequest(input!.uid,
        userName: input.userName,
        email: input.email,
        phoneNumber: input.phone,
        profileImage: input.photo));
  }
}

class UpdateInfoCaseInput {
  String uid;
  String userName;
  String email;
  String? phone;
  String? photo;

  UpdateInfoCaseInput(this.uid, this.userName, this.email,
      {this.phone, this.photo});
}
