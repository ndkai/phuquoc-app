import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/domain/repositories/user-repo.dart';

class GetUserProfileUc implements UseCase<ProfileSwagger, String> {
  final UserRepo userRepo;

  GetUserProfileUc(this.userRepo);

  @override
  Future<Either<Failure, ProfileSwagger>> call(String params) async {
    return userRepo.getUserProfile(params);
  }
}
