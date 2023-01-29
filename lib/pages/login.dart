import 'package:demalongsy/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';

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
            children: [
              const Spectral(
                text: "Demalonsy",
                color: C.primaryDefault,
                fontWeight: FW.bold,
                size: 40,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                  //------------------------
                  // Navigator.of(context).push(
                  //   CupertinoPageRoute<bool>(
                  //     fullscreenDialog: true,
                  //     builder: (BuildContext context) => HomePage(),
                  //   ),
                  // );
                },
                child: const Button(
                  text: "Sign In",
                  fontWeight: FW.bold,
                  color: C.dark2,
                  size: 16,
                  boxColor: C.secondaryDefault,
                  boxHeight: 48,
                  haveBorder: false,
                ),
              ),

              Text(
                'Custom Fonts',
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 40, fontWeight: FW.bold),
              )

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
