import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/user/domain/use_cases/get_user_info.dart';
import 'package:phuquoc/feature/user/domain/use_cases/get_user_profile_uc.dart';
import 'package:phuquoc/feature/user/domain/use_cases/update_user_info.dart';
import 'package:phuquoc/feature/user/presentation/manager/user_bloc/user_state.dart';

import 'bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserInfoUc getUserInfoUc;
  final UpdateUserInfoUc updateUserInfoUc;
  final GetUserProfileUc getUserProfileUc;
  UserBloc(this.getUserInfoUc, this.updateUserInfoUc, this.getUserProfileUc) : super(UserInitial()){
    on<UserLoadingE>(_loading);
    on<GetUserInfoE>(_getUserInfo);
    on<UpdateUserInforE>(_updateUserinfo);
    on<GetUserProfileE>(_getUserProfile);
  }

  Future<void> _getUserProfile(GetUserProfileE event, Emitter<UserState> emit) async {
    var result = await getUserProfileUc(event.userid);
    return emit(
        result.fold(
                (l) => UserError(l.msg),
                (r) => UserProfileLoaded(r)));
  }

  Future<void> _updateUserinfo(UpdateUserInforE event, Emitter<UserState> emit) async {
    var result = await updateUserInfoUc(event.request);
    print("_updateUserinfo request ${event.request.toJson()}");
    return emit(
        result.fold(
                (l) => UserError(l.msg),
                (r) => UpdateUserInfoLoaded()));
  }

  Future<void> _getUserInfo(GetUserInfoE event, Emitter<UserState> emit) async {
    var result = await getUserInfoUc(NoParams());
    return emit(
        result.fold(
                (l) => UserError(l.msg),
                (r) => GetUserInfoLoaded(r)));
  }

  Future<void> _loading(UserLoadingE event, Emitter<UserState> emit) async {
    return emit(
        UserLoading()
    );
  }

}
