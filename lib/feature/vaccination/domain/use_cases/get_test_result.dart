import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/vaccination/data/models/test_result.dart';
import 'package:phuquoc/feature/vaccination/domain/repositories/vaccination_repo.dart';

class GetTestResultUc implements UseCase<TestResult, String> {
  final VaccinationRepo _vaccinationRepo;

  GetTestResultUc(this._vaccinationRepo);

  @override
  Future<Either<Failure, TestResult>> call(String params) async {
    return _vaccinationRepo.getTestResult(params);
  }
}
