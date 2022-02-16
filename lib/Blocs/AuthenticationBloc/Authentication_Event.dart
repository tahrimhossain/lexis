part of 'Authentication_Bloc.dart';


abstract class AuthenticationEvent {}

class SignUpRequestEvent extends AuthenticationEvent{
  final String name;
  final String email;
  final String password;

  SignUpRequestEvent({required this.name,required this.password,required this.email}):super();
}

class LogInRequestEvent extends AuthenticationEvent{
  final String email;
  final String password;

  LogInRequestEvent({required this.password,required this.email}):super();
}

class LogOutRequestEvent extends AuthenticationEvent{

}

class AuthenticationEventFromStream extends AuthenticationEvent{
  CustomUser customUser;
  AuthenticationEventFromStream({required this.customUser}):super();
}
