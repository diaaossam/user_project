abstract class SignInStates{}
class InitialState extends SignInStates{}
class ChangePasswordVisibiltySignIn extends SignInStates{}
class LoginSuccessSignInState extends SignInStates{}
class LoginFailureSignInState extends SignInStates{
  final String error;

  LoginFailureSignInState(this.error);
}
class LoginLoadingSignInState extends SignInStates{}

class LoginSuccessGoogleState extends SignInStates{}
class LoginFailureGoogleState extends SignInStates{
  final String error;

  LoginFailureGoogleState(this.error);
}
class LoginLoadingGoogleState extends SignInStates{}

class RememberMeCheckBoxState extends SignInStates{}
class CheckFireStoreSuccess extends SignInStates{}
class CheckFireStoreFailure extends SignInStates{}

