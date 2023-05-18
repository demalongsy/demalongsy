import 'dart:convert' as convert;
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/profile/policy.dart';
import 'package:demalongsy/pages/choose_style/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usrnameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _retypepwdController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  String _usr = '';
  String _pwd = '';
  String _retypepwd = '';
  bool invisibleForPwd = true;
  bool invisibleForReTypePwd = true;
  bool? isChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: C.backgroundWhiteIvory,
      body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: C.primaryDefault,
                    child: SvgPicture.asset(
                      "assets/images/signup_BG.svg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 24, left: 24),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              "assets/images/arrow_back.svg",
                              width: 21,
                              height: 21,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 25),
                        const Padding(
                          padding: EdgeInsets.only(right: 24, left: 24),
                          child: Spectral(
                            text: "Create an account",
                            size: 36,
                            color: C.dark1,
                            fontWeight: FW.bold,
                            letterspacing: 0.64,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 24, left: 24),
                          child: Poppins(
                            text: "Fantastic to start to use application!",
                            size: 14,
                            color: C.disableTextfield,
                            fontWeight: FW.regular,
                            letterspacing: 0.4,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 24, left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Poppins(
                                text: "Username",
                                color: C.textDefault,
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
                                              extentOffset: _usrnameController
                                                  .text.length);
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
                                          : C.disableTextfield,
                                      fontWeight: FW.regular,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      fillColor: C.textField,
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 16),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: C.infoDefault),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: C.dark1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 27),
                        Padding(
                          padding: const EdgeInsets.only(right: 24, left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Poppins(
                                text: "Password",
                                color: C.textDefault,
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
                                    obscureText: invisibleForPwd,
                                    controller: _pwdController,
                                    onChanged: (value) =>
                                        setState(() => _pwd = value),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: _pwd.isNotEmpty
                                          ? C.dark2
                                          : C.disableTextfield,
                                      fontWeight: FW.regular,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      fillColor: C.textField,
                                      filled: true,
                                      suffixIcon: _pwd.isNotEmpty
                                          ? invisibleForPwd
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      invisibleForPwd = false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .visibility_off_outlined,
                                                    color: C.dark2,
                                                    size: 24,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      invisibleForPwd = true;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.visibility_outlined,
                                                    color: C.dark2,
                                                    size: 24,
                                                  ),
                                                )
                                          : null,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 16),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: C.infoDefault),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: C.dark1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 27),
                        Padding(
                          padding: const EdgeInsets.only(right: 24, left: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Poppins(
                                text: "Confirm Password",
                                color: C.textDefault,
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
                                    if (_retypepwdController.text.isNotEmpty) {
                                      _retypepwdController.selection =
                                          TextSelection(
                                              baseOffset: 0,
                                              extentOffset: _retypepwdController
                                                  .text.length);
                                    }
                                  },
                                  child: TextFormField(
                                    obscureText: invisibleForReTypePwd,
                                    controller: _retypepwdController,
                                    onChanged: (value) =>
                                        setState(() => _retypepwd = value),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: _retypepwd.isNotEmpty
                                          ? C.dark2
                                          : C.disableTextfield,
                                      fontWeight: FW.regular,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Retype password',
                                      fillColor: C.textField,
                                      filled: true,
                                      suffixIcon: _retypepwd.isNotEmpty
                                          ? invisibleForReTypePwd
                                              ? GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      invisibleForReTypePwd =
                                                          false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons
                                                        .visibility_off_outlined,
                                                    color: C.dark2,
                                                    size: 24,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      invisibleForReTypePwd =
                                                          true;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.visibility_outlined,
                                                    color: C.dark2,
                                                    size: 24,
                                                  ),
                                                )
                                          : null,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 16),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: C.infoDefault),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            const BorderSide(color: C.dark1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 27),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Checkbox(
                                value: isChecked,
                                activeColor: C.disableBackground,
                                onChanged: ((value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                }),
                              ),
                              const Poppins(
                                text: "I agree to the ",
                                size: 14,
                                color: C.textDefault,
                                fontWeight: FW.regular,
                                letterspacing: 0.4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(createTransitionRoute(
                                          PolicyPage(), 0, 1));
                                },
                                child: const Poppins(
                                  text: "Tems ",
                                  size: 14,
                                  color: C.textDefault,
                                  fontWeight: FW.bold,
                                  underline: true,
                                  letterspacing: 0.4,
                                ),
                              ),
                              const Poppins(
                                text: "and ",
                                size: 14,
                                color: C.textDefault,
                                fontWeight: FW.regular,
                                letterspacing: 0.4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(createTransitionRoute(
                                          PolicyPage(), 0, 1));
                                },
                                child: const Poppins(
                                  text: "Privacy Policy",
                                  size: 14,
                                  color: C.textDefault,
                                  fontWeight: FW.bold,
                                  underline: true,
                                  letterspacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        _usr.isNotEmpty &&
                                _pwd.isNotEmpty &&
                                _retypepwd.isNotEmpty &&
                                _pwd.compareTo(_retypepwd) == 0 &&
                                isChecked == true
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(right: 24, left: 24),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : GestureDetector(
                                        onTap: () async {
                                          Map<String, String> body = {
                                            "username": _usrnameController.text,
                                            "password": _pwdController.text,
                                          };
                                          var result = await _signUp(body);

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Tags()));

                                          FocusScope.of(context).unfocus();
                                        },
                                        child: const Button(
                                          text: "Sign Up",
                                          fontWeight: FW.bold,
                                          color: C.dark2,
                                          size: 16,
                                          boxColor: C.secondaryDefault,
                                          boxHeight: 48,
                                          haveBorder: false,
                                        ),
                                      ))
                            : const Padding(
                                padding: EdgeInsets.only(right: 24, left: 24),
                                child: Button(
                                  text: "Sign Up",
                                  fontWeight: FW.bold,
                                  color: C.textDefault2,
                                  size: 16,
                                  boxColor: C.secondaryPressed,
                                  boxHeight: 48,
                                  haveBorder: false,
                                  letterspacing: 0.64,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }

  _signUp(Map<String, String> body) async {
    try {
      var url = '${Url.baseurl}/auth/register';
      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8'
      };

      var response = await http.post(Uri.parse(url),
          headers: header, body: convert.jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = convert.jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', result["token"]);
        await prefs.setString('user_id', result["user_id"]);
        await prefs.setString('username', _usrnameController.text);

        return result;
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
