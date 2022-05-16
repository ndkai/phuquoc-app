import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';

abstract class UserRepo {
  Future<Either<Failure, UserInfoSwagger>> getUserInfor();
  Future<Either<Failure, bool>> updateUserInfor(UpdateInforRequest request);
  Future<Either<Failure, ProfileSwagger>> getUserProfile(String userId);

}
