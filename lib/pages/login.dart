import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                fontWeight: FW.bold,
                size: 40,
              ),
              const Button(
                text: "Sign In",
                fontWeight: FW.bold,
                color: C.dark2,
                size: 16,
                boxColor: C.secondaryDefault,
                boxHeight: 48,
                haveBorder: false,
              ),
              SvgPicture.asset("assets/images/circle.svg"),
              // const InputField(
              //   text: 'eiei'
              // )
            ],
          ),
        ),
      ),
    );
  }
}
