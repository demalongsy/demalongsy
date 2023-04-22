import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentpwdController = new TextEditingController();
  TextEditingController _newpwdController = new TextEditingController();
  TextEditingController _confirmpwdController = new TextEditingController();

  String _currentpwd = '';
  String _newpwd = '';
  String _confirmpwd = '';
  bool invisibleForCurrentPwd = true;
  bool invisibleForNewPwd = true;
  bool invisibleForConfirmPwd = true;

  // Image
  File? image;

  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: C.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              backgroundColor: C.white,
              elevation: 0,
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: C.dark2,
                          size: 16.0,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        }),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Poppins(
                        text: "Change Password",
                        size: 20,
                        color: C.dark1,
                        fontWeight: FW.bold,
                        letterspacing: 0.64,
                      ),
                    ),
                    Expanded(child: Container()),
                    checkAllSpaces(_currentpwd) &&
                            checkAllSpaces(_newpwd) &&
                            checkAllSpaces(_confirmpwd) &&
                            _newpwd.compareTo(_confirmpwd) == 0
                        ? GestureDetector(
                            onTap: () {
                              print(_currentpwd);
                            },
                            child: const Poppins(
                              text: "Save",
                              size: 16,
                              color: C.primaryDefault,
                              fontWeight: FW.bold,
                              letterspacing: 0.64,
                            ),
                          )
                        : const Poppins(
                            text: "Save",
                            size: 16,
                            color: C.disableTextfield,
                            fontWeight: FW.bold,
                            letterspacing: 0.64,
                          ),
                  ],
                ),
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  profilePhoto(),
                  const SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Poppins(
                        text: "Update password",
                        size: 12,
                        color: C.textDefault,
                        fontWeight: FW.bold),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  TextFieldCurrentPass(""),
                  TextFieldNewPass(""),
                  TextFieldConfirmPass(""),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextFieldCurrentPass(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_currentpwdController.text.isNotEmpty) {
          _currentpwdController.selection = TextSelection(
              baseOffset: 0, extentOffset: _currentpwdController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30),
        child: TextFormField(
          obscureText: invisibleForCurrentPwd,
          onChanged: (value) => setState(() => _currentpwd = value),
          controller: _currentpwdController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            icon: const Poppins(
                text: "Current password   ",
                size: 13.5,
                color: C.dark2,
                fontWeight: FW.light),
            hintText: placeholder == "" ? "At least 8 characters" : placeholder,
            hintStyle: placeholder != ""
                ? const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.textDefault,
                  )
                : const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.disableTextfield,
                  ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: C.disableTextfield),
            ),
            suffixIcon: _currentpwd.isNotEmpty
                ? invisibleForCurrentPwd
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForCurrentPwd = false;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_off_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForCurrentPwd = true;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                : null,
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget TextFieldNewPass(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_newpwdController.text.isNotEmpty) {
          _newpwdController.selection = TextSelection(
              baseOffset: 0, extentOffset: _newpwdController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 30, right: 30),
        child: TextFormField(
          obscureText: invisibleForNewPwd,
          onChanged: (value) => setState(() => _newpwd = value),
          controller: _newpwdController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            icon: const Poppins(
                text: "New password         ",
                size: 13.5,
                color: C.dark2,
                fontWeight: FW.light),
            hintText: placeholder == "" ? "At least 8 characters" : placeholder,
            hintStyle: placeholder != ""
                ? const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.textDefault,
                  )
                : const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.disableTextfield,
                  ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: C.disableTextfield),
            ),
            suffixIcon: _newpwd.isNotEmpty
                ? invisibleForNewPwd
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForNewPwd = false;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_off_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForNewPwd = true;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                : null,
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget TextFieldConfirmPass(String placeholder) {
    return GestureDetector(
      onDoubleTap: () {
        if (_confirmpwdController.text.isNotEmpty) {
          _confirmpwdController.selection = TextSelection(
              baseOffset: 0, extentOffset: _confirmpwdController.text.length);
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 28, left: 30, right: 30),
        child: TextFormField(
          obscureText: invisibleForConfirmPwd,
          onChanged: (value) => setState(() => _confirmpwd = value),
          controller: _confirmpwdController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            icon: const Poppins(
                text: "Confirm password  ",
                size: 13.5,
                color: C.dark2,
                fontWeight: FW.light),
            hintText: placeholder == "" ? "At least 8 characters" : placeholder,
            hintStyle: placeholder != ""
                ? const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.textDefault,
                  )
                : const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FW.light,
                    color: C.disableTextfield,
                  ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: C.disableTextfield),
            ),
            suffixIcon: _confirmpwd.isNotEmpty
                ? invisibleForConfirmPwd
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForConfirmPwd = false;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_off_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            invisibleForConfirmPwd = true;
                          });
                        },
                        child: const Icon(
                          Icons.visibility_outlined,
                          color: C.disableBackground,
                          size: 20,
                        ),
                      )
                : null,
          ),
          onSaved: (String? value) {},
        ),
      ),
    );
  }

  Widget profilePhoto() {
    return Center(
      child: image == null
          ? Container(
              width: 98,
              height: 98,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
                  ),
                ),
              ),
            )
          : Container(
              width: 98,
              height: 98,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.file(
                  image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              )),
    );
  }
}
