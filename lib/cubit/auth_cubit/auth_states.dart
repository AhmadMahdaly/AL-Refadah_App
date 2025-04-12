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
