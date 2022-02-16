import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lexis/Models/CustomUser.dart';
import 'package:lexis/Models/LogInWithEmailAndPasswordFailure.dart';
import 'package:lexis/Models/SignUpWithEmailAndPasswordFailure.dart';
import 'package:lexis/Services/Authentication.dart';

part 'Authentication_Event.dart';
part 'Authentication_State.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Authentication auth;
  StreamSubscription<dynamic> ? customUserSubscription;
  AuthenticationBloc(this.auth) : super(DeterminingAuthenticationState()) {
    customUserSubscription = auth.user.listen((customUser) {
      add(AuthenticationEventFromStream(customUser: customUser));
    });
    on<AuthenticationEventFromStream>((event, emit) {
      if(event.customUser.id == ''){
        emit(NotAuthenticatedState());
      }else{
        if(event.customUser.name != null){
          emit(AuthenticatedState(customUser: event.customUser));
        }
      }
    });

    on<SignUpRequestEvent>((event, emit) async{
      emit(DeterminingAuthenticationState());
      try{
        await auth.signUp(name:event.name,email: event.email, password: event.password);
      }on SignUpWithEmailAndPasswordFailure catch(e){
        emit(NotAuthenticatedState(signUpWithEmailAndPasswordFailure: e));
      }
    });

    on<LogInRequestEvent>((event, emit) async{
      emit(DeterminingAuthenticationState());
      try{
        await auth.logIn(email: event.email, password: event.password);
      }on LogInWithEmailAndPasswordFailure catch(e){
        emit(NotAuthenticatedState(logInWithEmailAndPasswordFailure: e));
      }
    });

    on<LogOutRequestEvent>((event, emit) async{
      emit(DeterminingAuthenticationState());
      try{
        await auth.logOut();
      }catch(e){
        print(e);
      }
    });

  }

  @override
  Future<void> close() {
    customUserSubscription?.cancel();
    return super.close();
  }
}
