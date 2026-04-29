

import '../../data/model/user_model.dart';

sealed class AuthStates {}

final class AuthInitialState extends AuthStates {}

final class AuthLoadingState extends AuthStates {}

final class AuthSuccessState extends AuthStates {
  final LoginModel user;
  AuthSuccessState(this.user);
}

final class AuthErrorState extends AuthStates {
  final String message;
  AuthErrorState(this.message);
}