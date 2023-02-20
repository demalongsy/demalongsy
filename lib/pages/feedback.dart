import 'package:demalongsy/custom/toolkit.dart';
import 'package:flutter/material.dart';

class Feedback extends StatefulWidget {
  const Feedback({super.key});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: C.backgroundWhiteIvory,
        body: SingleChildScrollView(),
      ),
    );
  }
}
