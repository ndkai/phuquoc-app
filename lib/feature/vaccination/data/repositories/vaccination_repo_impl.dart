import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import 'package:phuquoc/feature/vaccination/data/data_sources/vaccination_datasource.dart';
import 'package:phuquoc/feature/vaccination/data/models/test_result.dart';
import 'package:phuquoc/feature/vaccination/domain/repositories/vaccination_repo.dart';

class VaccinationRepoImpl implements VaccinationRepo{
  final VaccinationDatasource datasource;
  final NetworkInfo networkInfo;

  VaccinationRepoImpl(this.datasource, this.networkInfo);
  @override
  Future<Either<Failure, TestResult>> getTestResult(String phoneNumber) {
    return _getUserProfile(datasource.getTestResult(phoneNumber));
  }

  Future<Either<Failure, TestResult>> _getUserProfile(
      Future<TestResult> getData) async {
    var connected = await networkInfo.isConnected;
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
}