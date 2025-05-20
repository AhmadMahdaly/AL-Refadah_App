abstract class AuthStates {}

class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  LoginErrorState(this.message);
  final String message;
}

///Logout
class LogoutLoadingState extends AuthStates {}

class LogoutSuccessState extends AuthStates {}

class LogoutErrorState extends AuthStates {
  LogoutErrorState(this.message);
  final String message;
}

///Login with code
class LoginWithCodeLoadingState extends AuthStates {}

class LoginWithCodeSuccessState extends AuthStates {}

class LoginWithCodeErrorState extends AuthStates {
  LoginWithCodeErrorState(this.message);
  final String message;
}

///
final class SetUpLoadingState extends AuthStates {}

final class SetUpSuccessState extends AuthStates {}

final class SetUpErrorState extends AuthStates {}

///
final class RefreshTokenLoadingState extends AuthStates {}

final class RefreshTokenSuccessState extends AuthStates {}

final class RefreshTokenErrorState extends AuthStates {}

///
final class IsLoginLoadingState extends AuthStates {}

final class IsLoginSuccessState extends AuthStates {}

final class IsLoginErrorState extends AuthStates {}

///
final class RegisterLoadingState extends AuthStates {}

final class RegisterSuccessState extends AuthStates {}

final class RegisterErrorState extends AuthStates {
  RegisterErrorState(this.message);
  final String message;
}

///
final class VerifyRegisterLoadingState extends AuthStates {}

final class VerifyRegisterSuccessState extends AuthStates {}

final class VerifyRegisterErrorState extends AuthStates {
  VerifyRegisterErrorState(this.message);
  final String message;
}

///
final class ResendOTPLoadingState extends AuthStates {}

final class ResendOTPSuccessState extends AuthStates {}

final class ResendOTPErrorState extends AuthStates {
  ResendOTPErrorState(this.message);
  final String message;
}

///
final class VerifyLoginLoadingState extends AuthStates {}

final class VerifyLoginSuccessState extends AuthStates {}

final class VerifyLoginErrorState extends AuthStates {
  VerifyLoginErrorState(this.message);
  final String message;
}

class AuthStateStatus extends AuthStates {
  AuthStateStatus(this.status);
  final AuthStatus status;
}

enum AuthStatus { authenticated, unauthenticated }

class AuthStateShowLogoutDialog extends AuthStates {}
