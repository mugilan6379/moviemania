import 'package:flutter/material.dart';
import 'package:moviemania/authentication/welcomePage.dart';
import 'movieCell/listPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white
          )
      ),
      themeMode: ThemeMode.dark,
      home: welcomeScreen(),
    );
  }
}
