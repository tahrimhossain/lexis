import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'Authentication_Event.dart';
part 'Authentication_State.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
