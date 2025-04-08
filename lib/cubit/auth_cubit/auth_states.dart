abstract class AuthStates {}

class AppLoginInitialState extends AuthStates {}

class AppLoginLoadingState extends AuthStates {}

class AppLoginSuccessState extends AuthStates {}

class AppLoginErrorState extends AuthStates {
  AppLoginErrorState(this.message);
  final String message;
}

class AppLogoutSuccessState extends AuthStates {}

class AppLoginWithCodeErrorState extends AuthStates {
  AppLoginWithCodeErrorState(this.message);
  final String message;
}
