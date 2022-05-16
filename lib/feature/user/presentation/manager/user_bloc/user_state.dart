import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}


class UserError extends UserState {
  final String msg;

  UserError(this.msg);
  @override
  List<Object> get props => [msg];
}

class GetUserInfoLoaded extends UserState {
  final UserInfoSwagger userInfoSwagger;

  GetUserInfoLoaded(this.userInfoSwagger);
  @override
  List<Object> get props => [userInfoSwagger];
}

class UpdateUserInfoLoaded extends UserState {

  UpdateUserInfoLoaded();
  @override
  List<Object> get props => [];
}

class UserProfileLoaded extends UserState {
  final ProfileSwagger data;
  UserProfileLoaded(this.data);
  @override
  List<Object> get props => [data];
}

