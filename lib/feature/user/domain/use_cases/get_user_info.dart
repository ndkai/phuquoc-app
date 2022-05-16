import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/domain/repositories/user-repo.dart';

class GetUserInfoUc implements UseCase<UserInfoSwagger, NoParams> {
  final UserRepo userRepo;

  GetUserInfoUc(this.userRepo);

  @override
  Future<Either<Failure, UserInfoSwagger>> call(NoParams params) async {
    return userRepo.getUserInfor();
  }
}
