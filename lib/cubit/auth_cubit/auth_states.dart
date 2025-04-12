abstract class AuthStates {}

class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  LoginErrorState(this.message);
  final String message;
}

class LogoutSuccessState extends AuthStates {}

class LoginWithCodeErrorState extends AuthStates {
  LoginWithCodeErrorState(this.message);
  final String message;
}

final class SetUpLoadingState extends AuthStates {}

final class SetUpSuccessState extends AuthStates {}

final class SetUpErrorState extends AuthStates {}

final class RefreshTokenLoadingState extends AuthStates {}

final class RefreshTokenSuccessState extends AuthStates {}

final class RefreshTokenErrorState extends AuthStates {}

final class IsLoginLoadingState extends AuthStates {}

final class IsLoginSuccessState extends AuthStates {}

final class IsLoginErrorState extends AuthStates {}
