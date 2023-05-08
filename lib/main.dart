import 'package:demalongsy/pages/choose_style/tags.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/auth/login.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:demalongsy/pages/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: CupertinoApp(
            title: 'Flutter Demo',
            home: ViewPost(
              block_id: '',
              tags: ['Y2K'],
            )));
  }
}
