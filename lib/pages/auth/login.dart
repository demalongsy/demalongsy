import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usrnameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String _usr = '';
  String _pwd = '';
  bool invisible = true;
  bool isLoading = false;
  bool isChecked = false;
  bool hasProblem = false;
  String msg = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: C.primaryDefault,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: (() {
                FocusScope.of(context).unfocus();
                setState(() {
                  hasProblem = false;
                });
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
                                      borderSide: hasProblem
                                          ? BorderSide(
                                              color: C.dangerDefault, width: 2)
                                          : const BorderSide(color: C.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hasProblem
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Poppins(
                                      text: msg,
                                      color: C.dangerDefault,
                                      fontWeight: FontWeight.normal,
                                      size: 12,
                                      letterspacing: 0.2,
                                    ),
                                  )
                                : Container()
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
                                      borderSide: hasProblem
                                          ? BorderSide(
                                              color: C.dangerDefault, width: 2)
                                          : const BorderSide(color: C.white),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hasProblem
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Poppins(
                                      text: msg,
                                      color: C.dangerDefault,
                                      fontWeight: FontWeight.normal,
                                      size: 12,
                                      letterspacing: 0.2,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isChecked = true;
                            });
                            Map<String, String> body = {
                              "username": _usrnameController.text,
                              "password": _pwdController.text,
                            };
                            await _logIn(body);
                            FocusScope.of(context).unfocus();
                            if (isLoading) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Navbar()));
                            }
                          },
                          child: isChecked
                              ? CircularProgressIndicator()
                              : Button(
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
                      SizedBox(height: MediaQuery.of(context).size.height / 27),
                      Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: [
                          const Poppins(
                            text: "Don't have an account ? ",
                            size: 14,
                            color: C.white,
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
                              color: C.white,
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

  _logIn(Map<String, String> body) async {
    try {
      var url = '${Url.baseurl}/auth/login';
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      var response = await http.post(Uri.parse(url),
          headers: header, body: convert.jsonEncode(body));
      var result = convert.jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result["token"]);
        await prefs.setString('user_id', result["user_id"]);
        await prefs.setString('username', _usrnameController.text);

        if (result["msg"] == 'success') {
          setState(() {
            isLoading = true;
            isChecked = false;
          });
        }
      } else {
        setState(() {
          isChecked = false;
          hasProblem = true;
          msg = result["msg"];
        });

        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
