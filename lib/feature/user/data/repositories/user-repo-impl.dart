import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import 'package:phuquoc/feature/user/data/data_sources/user_datasourse.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';
import 'package:phuquoc/feature/user/domain/repositories/user-repo.dart';

class UserRepoImpl extends UserRepo {
  final NetworkInfo? networkInfo;
  final UserDatasource? datasource;

  UserRepoImpl({
    this.networkInfo,
    this.datasource,
  });


  @override
  Future<Either<Failure, UserInfoSwagger>> getUserInfor() {
    return _getUserInfor(datasource!.getUserinfo());
  }

  @override
  Future<Either<Failure, bool>> updateUserInfor(UpdateInforRequest request) {
    return _updateUserInfor(datasource!.updateUserInfor(request));
  }

  @override
  Future<Either<Failure, ProfileSwagger>> getUserProfile(String userId) {
    return _getUserProfile(datasource!.getUserProfile(userId));
  }

  Future<Either<Failure, ProfileSwagger>> _getUserProfile(
      Future<ProfileSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error!));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, bool>> _updateUserInfor(
      Future<bool> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(!data){
          return Left(ServerFailure("Thất bại"));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }


  Future<Either<Failure, UserInfoSwagger>> _getUserInfor(
      Future<UserInfoSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }





}
