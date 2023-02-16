import 'package:demalongsy/pages/home.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/signup.dart';
import 'package:demalongsy/pages/tags.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          child: SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: C.dangerDefault,
              child: ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: C.dangerDefault,
                        child: SvgPicture.asset(
                          "assets/images/login_BG.svg",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        //color: C.dangerDefault,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.35,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.65,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),

                                    // height: 60,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Username'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),

                                    // height: 60,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'Username'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Tags()));
                                      },
                                      child: const Button(
                                        text: "Log In",
                                        fontWeight: FW.bold,
                                        color: C.dark2,
                                        size: 16,
                                        boxColor: C.primaryDefault,
                                        boxHeight: 48,
                                        haveBorder: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
