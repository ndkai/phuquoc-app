import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';
import 'package:phuquoc/feature/user/domain/repositories/user-repo.dart';

class UpdateUserInfoUc implements UseCase<bool, UpdateInforRequest> {
  final UserRepo userRepo;

  UpdateUserInfoUc(this.userRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateInforRequest params) async {
    return userRepo.updateUserInfor(params);
  }
}
