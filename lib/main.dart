import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Services/API.dart';
import 'package:lexis/Services/Authentication.dart';
import 'package:lexis/Views/CategoryView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lexis/Views/LogInSignUpView.dart';
import 'Blocs/AuthenticationBloc/Authentication_Bloc.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<API>(
        create: (context) => API(),
      ),
      RepositoryProvider<Authentication>(
        create: (context) => Authentication(),
      ),
    ],
    child: BlocProvider(
      create: (BuildContext context) => AuthenticationBloc(
          RepositoryProvider.of<Authentication>(context)
      ),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Lexis',
        theme: ThemeData(
            primaryTextTheme: GoogleFonts.latoTextTheme(),
            appBarTheme: const AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
              titleTextStyle: TextStyle(color: Colors.white),
              iconTheme: IconThemeData(color: Colors.white),
            )
        ),
        home: BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context, state) {

          if(state is DeterminingAuthenticationState){
            return const Scaffold(
              backgroundColor: Color(0xFF283048),
              body: Center(child: CircularProgressIndicator(),),
            );
          }else if(state is AuthenticatedState){
            return CategoryView();
          }else{
            return LogInSignUpView();
          }
        }

        )

    );
  }
}
