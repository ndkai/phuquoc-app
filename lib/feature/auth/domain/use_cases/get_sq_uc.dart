import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class GetSQUC implements UseCase<QuestionSwagger, NoParams> {
  final AuthRepo authRepo;

  GetSQUC(this.authRepo);

  @override
  Future<Either<Failure, QuestionSwagger>> call(NoParams params) async {
    return authRepo. getSecurityQuestion();
  }
}
