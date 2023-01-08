import 'package:demalongsy/custom/color.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/widget/font.dart';

class Longin extends StatefulWidget {
  const Longin({super.key});

  @override
  State<Longin> createState() => _LonginState();
}

class _LonginState extends State<Longin> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
            child: Spectral(
          text: "Demalonsy",
          color: C.primaryDefault,
          fontWeight: FontWeight.bold,
          size: 40,
        )),
      ),
    );
  }
}
