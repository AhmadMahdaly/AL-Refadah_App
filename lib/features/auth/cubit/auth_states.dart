abstract class AuthStates {
  const AuthStates({this.isLoading = false});
  final bool isLoading;
}

class LoginInitialState extends AuthStates {}

class LoginLoadingState extends AuthStates {
  const LoginLoadingState() : super(isLoading: true);
}

class LoginSuccessState extends AuthStates {}

class LoginErrorState extends AuthStates {
  LoginErrorState(this.message);
  final String message;
}

///Login with code
class LoginWithCodeLoadingState extends AuthStates {
  const LoginWithCodeLoadingState() : super(isLoading: true);
}

class LoginWithCodeSuccessState extends AuthStates {}

class LoginWithCodeErrorState extends AuthStates {
  LoginWithCodeErrorState(this.message);
  final String message;
}

///
final class RegisterLoadingState extends AuthStates {
  const RegisterLoadingState() : super(isLoading: true);
}

final class RegisterSuccessState extends AuthStates {}

final class RegisterErrorState extends AuthStates {
  RegisterErrorState(this.message);
  final String message;
}

///
final class VerifyRegisterLoadingState extends AuthStates {
  const VerifyRegisterLoadingState() : super(isLoading: true);
}

final class VerifyRegisterSuccessState extends AuthStates {}

final class VerifyRegisterErrorState extends AuthStates {
  VerifyRegisterErrorState(this.message);
  final String message;
}

///
final class ResendOTPLoadingState extends AuthStates {
  const ResendOTPLoadingState() : super(isLoading: true);
}

final class ResendOTPSuccessState extends AuthStates {}

final class ResendOTPErrorState extends AuthStates {
  ResendOTPErrorState(this.message);
  final String message;
}

///
final class VerifyLoginLoadingState extends AuthStates {
  const VerifyLoginLoadingState() : super(isLoading: true);
}

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
