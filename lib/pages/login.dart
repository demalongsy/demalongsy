import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/signup.dart';
import 'package:demalongsy/pages/tags.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usrnameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  String _usr = '';
  String _pwd = '';
  bool invisible = true;

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
        backgroundColor: C.primaryDefault,
        body: Form(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: (() {
                FocusScope.of(context).unfocus();
              }),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: C.primaryDefault,
                    child: SvgPicture.asset(
                      "assets/images/login_BG.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Poppins(
                              text: "Username",
                              color: C.disableText,
                              fontWeight: FontWeight.normal,
                              size: 12,
                              letterspacing: 0.2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 48,
                              child: GestureDetector(
                                onDoubleTap: () {
                                  if (_usrnameController.text.isNotEmpty) {
                                    _usrnameController.selection =
                                        TextSelection(
                                            baseOffset: 0,
                                            extentOffset:
                                                _usrnameController.text.length);
                                  }
                                },
                                child: TextFormField(
                                  controller: _usrnameController,
                                  onChanged: (value) =>
                                      setState(() => _usr = value),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: _usr.isNotEmpty
                                        ? C.dark2
                                        : C.disableBackground,
                                    fontWeight: FW.regular,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    fillColor: C.textField,
                                    filled: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 16),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: C.infoDefault),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: C.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 55),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Poppins(
                              text: "Password",
                              color: C.disableText,
                              fontWeight: FontWeight.normal,
                              size: 12,
                              letterspacing: 0.2,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            SizedBox(
                              height: 48,
                              child: GestureDetector(
                                onDoubleTap: () {
                                  if (_pwdController.text.isNotEmpty) {
                                    _pwdController.selection = TextSelection(
                                        baseOffset: 0,
                                        extentOffset:
                                            _pwdController.text.length);
                                  }
                                },
                                child: TextFormField(
                                  obscureText: invisible,
                                  controller: _pwdController,
                                  onChanged: (value) =>
                                      setState(() => _pwd = value),
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: _pwd.isNotEmpty
                                        ? C.dark2
                                        : C.disableBackground,
                                    fontWeight: FW.regular,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    fillColor: C.textField,
                                    filled: true,
                                    suffixIcon: invisible
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                invisible = false;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.visibility_off_outlined,
                                              color: C.disableBackground,
                                              size: 24,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                invisible = true;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.visibility_outlined,
                                              color: C.disableBackground,
                                              size: 24,
                                            ),
                                          ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 16),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: C.infoDefault),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: C.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Navbar()));
                          },
                          child: const Button(
                            text: "Sign In",
                            fontWeight: FW.bold,
                            color: C.dark2,
                            size: 16,
                            letterspacing: 0.64,
                            boxColor: C.primaryDefault,
                            boxHeight: 48,
                            haveBorder: false,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 27),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Divider(
                                color: C.white,
                                thickness: 1,
                                height: 3,
                              ),
                            ),
                          ),
                          Poppins(
                            text: " Or login with ",
                            size: 14,
                            color: C.white,
                            fontWeight: FW.regular,
                            letterspacing: 0.4,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Divider(
                                color: C.white,
                                thickness: 1,
                                height: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 27),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Button(
                            text: "Google",
                            fontWeight: FW.regular,
                            color: C.white,
                            size: 16,
                            letterspacing: 0.64,
                            boxColor: C.dark2,
                            boxHeight: 48,
                            haveBorder: false,
                            hasImg: true,
                            pathImg: "assets/images/G.svg",
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 9.5),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          const Poppins(
                            text: "Don't have an account ? ",
                            size: 14,
                            color: C.textDefault,
                            fontWeight: FW.regular,
                            letterspacing: 0.4,
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.of(context, rootNavigator: true).push(
                                  createTransitionRoute(const SignUp(), 1, 0));
                            }),
                            child: const Poppins(
                              text: "Sign up",
                              size: 14,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                              letterspacing: 0.4,
                              underline: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
