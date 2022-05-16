import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/feature/vaccination/data/models/test_result.dart';

abstract class VaccinationRepo {
  Future<Either<Failure, TestResult>> getTestResult(String phoneNumber);

}
