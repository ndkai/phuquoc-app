import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUserInfoE extends UserEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class UpdateUserInforE extends UserEvent{
  final UpdateInforRequest request;

  UpdateUserInforE(this.request);
  @override
  // TODO: implement props
  List<Object?> get props => [request];

}

class GetUserProfileE extends UserEvent{
  final String userid;

  GetUserProfileE(this.userid);
  @override
  // TODO: implement props
  List<Object?> get props => [userid];

}

class UserLoadingE extends UserEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
