import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexis/Services/API.dart';
import 'package:lexis/Views/CategoryView.dart';
import 'package:google_fonts/google_fonts.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<API>(
        create: (context) => API(),
      ),
    ],
    child: const MyApp(),
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
        home: CategoryView()

    );
  }
}
