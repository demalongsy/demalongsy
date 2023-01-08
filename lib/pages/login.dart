import 'package:demalongsy/custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/button.dart';

class Longin extends StatefulWidget {
  const Longin({super.key});

  @override
  State<Longin> createState() => _LonginState();
}

class _LonginState extends State<Longin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Spectral(
                text: "Demalonsy",
                color: C.primaryDefault,
                fontWeight: FontWeight.bold,
                size: 40,
              ),
              const Button(
                text: "Sign In",
                fontWeight: FontWeight.bold,
                color: C.dark2,
                size: 16,
                boxColor: C.secondaryDefault,
                boxHeight: 48,
                haveBorder: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
