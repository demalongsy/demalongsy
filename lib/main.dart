import 'package:demalongsy/pages/choose_style.dart';
import 'package:demalongsy/pages/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/login.dart';
import 'package:demalongsy/pages/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        title: 'Flutter Demo',

        // home: const Longin(),
        //home: ProfileScreen(),
        home: Tags());
    // home: ChooseStyle());
    // home: Loading());
  }
}
