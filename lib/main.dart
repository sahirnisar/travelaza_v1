import 'package:authentification/logged/Login.dart';
import 'package:authentification/logged/Signup.dart';
import 'package:authentification/logged/Start.dart';
import 'package:flutter/material.dart';
import 'logged/Homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'logged/backButton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
      },
    );
  }
}