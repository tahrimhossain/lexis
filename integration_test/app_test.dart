import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lexis/main.dart' as app;

void main(){

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Sign in', (WidgetTester tester) async {

        app.main();

        await tester.pumpAndSettle();

        expect(find.byType(TextFormField), findsNWidgets(2));

        await tester.enterText(find.byType(TextFormField).first, 'tahrimh246@gmail.com');

        await tester.pump(const Duration(seconds:2));

        await tester.enterText(find.byType(TextFormField).last, '123456');

        await tester.pump(const Duration(seconds:2));

        await tester.tap(find.byIcon(Icons.arrow_forward));

        await tester.pumpAndSettle();

        expect(find.byType(ListTile),findsNWidgets(4));

        await tester.tap(find.byType(TextButton).first);

        await tester.pumpAndSettle(const Duration(seconds:5));

        NavigatorState navigator = tester.state(find.byType(Navigator));

        navigator.pop();

        await tester.pumpAndSettle(const Duration(seconds:5));

        await tester.tap(find.descendant(of: find.byType(AppBar), matching: find.byType(IconButton).first,));

        await tester.pumpAndSettle();

        await tester.tap(find.text('LogOut'));

        await tester.pumpAndSettle(const Duration(seconds:5));


      















      });
}