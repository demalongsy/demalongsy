import 'package:demalongsy/pages/home.dart';
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
    return Scaffold(
      backgroundColor: C.primaryDefault,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(82.0)),
                  color: C.dark1,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: C.backgroundWhiteIvory,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2000),
                    topRight: Radius.circular(2000),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 112, left: 25),
            child: Spectral(
              text: "Sign in",
              size: 60,
              color: C.white,
              fontWeight: FW.regular,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 179, left: 161),
            child: SvgPicture.asset(
              "assets/images/tags.svg",
              height: 70,
            ),
          )
        ],
      ),
    );
  }
}
