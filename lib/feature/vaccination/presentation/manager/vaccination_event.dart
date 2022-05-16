import 'package:equatable/equatable.dart';

abstract class VaccinationEvent extends Equatable {
  const VaccinationEvent();
}

class GetTestResultE extends VaccinationEvent {
  final String phoneNumber;

  GetTestResultE(this.phoneNumber);
  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class VaccinationLoadingE extends VaccinationEvent {

  VaccinationLoadingE();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

