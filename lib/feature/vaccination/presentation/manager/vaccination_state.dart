import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/vaccination/data/models/test_result.dart';

abstract class VaccinationState extends Equatable {
  const VaccinationState();
}

class VaccinationInitial extends VaccinationState {
  @override
  List<Object> get props => [];
}


class VaccinationLoading extends VaccinationState {
  @override
  List<Object> get props => [];
}



class VaccinationError extends VaccinationState {
  final String msg;

  VaccinationError(this.msg);
  @override
  List<Object> get props => [msg];
}


class GetTestResultLoaded extends VaccinationState {
  final TestResult testResult;

  GetTestResultLoaded(this.testResult);
  @override
  List<Object> get props => [testResult];
}


