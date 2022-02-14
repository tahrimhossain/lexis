part of 'Authentication_Bloc.dart';


abstract class AuthenticationState {}

class DeterminingAuthenticationState extends AuthenticationState {}

class NotAuthenticatedState extends AuthenticationState{
  SignUpWithEmailAndPasswordFailure ? signUpWithEmailAndPasswordFailure;
  LogInWithEmailAndPasswordFailure ? logInWithEmailAndPasswordFailure;

  NotAuthenticatedState({this.signUpWithEmailAndPasswordFailure,this.logInWithEmailAndPasswordFailure}):super();
}

class AuthenticatedState extends AuthenticationState{

  final CustomUser customUser;

  AuthenticatedState({required this.customUser}):super();

}
