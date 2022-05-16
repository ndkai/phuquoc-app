import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:phuquoc/feature/vaccination/domain/use_cases/get_test_result.dart';
import 'bloc.dart';

class VaccinationBloc extends Bloc<VaccinationEvent, VaccinationState> {
  final GetTestResultUc getTestResultUc;

  VaccinationBloc(this.getTestResultUc) : super(VaccinationInitial()){
    on<VaccinationLoadingE>(_loading);
    on<GetTestResultE>(_getTestResult);
  }

  Future<void> _getTestResult(GetTestResultE event, Emitter<VaccinationState> emit) async {
    var result = await getTestResultUc(event.phoneNumber);
    return emit(
        result.fold(
                (l) => VaccinationError(l.msg),
                (r) => GetTestResultLoaded(r)));
  }

  Future<void> _loading(VaccinationLoadingE event, Emitter<VaccinationState> emit) async {
    return emit(
        VaccinationLoading()
    );
  }

}
