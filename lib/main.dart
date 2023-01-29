import 'pages/login.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/chooseStyle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const Longin(),
        // home: ProfileScreen(),
        // home: const Navbar(),
        home: const ChooseStyle());
  }
}
