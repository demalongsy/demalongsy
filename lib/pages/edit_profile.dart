import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: C.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
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
                            text: "Edit Profile",
                            size: 20,
                            color: C.dark1,
                            fontWeight: FW.bold,
                            letterspacing: 0.64,
                          ),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          child: const Poppins(
                            text: "Save",
                            size: 16,
                            color: C.primaryDefault,
                            fontWeight: FW.bold,
                            letterspacing: 0.64,
                          ),
                        )
                      ]),
                ),
              )),
          body: Container(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 98,
                          height: 98,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: C.secondaryDefault,
                              ),
                              child: const Icon(
                                Icons.mode_edit_rounded,
                                color: C.dark2,
                                size: 20,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldUsername(),
                  TextFieldName(""),
                  TextFieldEmail("K. Payoungdech"),
                  TextFieldBio("payoungdech.k@gmail.com"),
                  // buildTextField("Email", "********"),
                  // buildTextField("Bio", "TLV, Israel"),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget TextFieldUsername() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it

            decoration: const InputDecoration(
                icon: Poppins(
                    text: "Username",
                    size: 14,
                    color: C.dark2,
                    fontWeight: FW.light),
                hintText: "     K. Payoungdech",
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FW.light,
                  color: C.disableTextfield,
                )),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ],
      ),
      // SizedBox(
      //   width: 20,
      // ),
    );
  }

  Widget TextFieldName(String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it

            decoration: InputDecoration(
                icon: const Poppins(
                    text: "Name        ",
                    size: 14,
                    color: C.dark2,
                    fontWeight: FW.light),
                hintText:
                    placeholder == "" ? "     Name" : "      " + placeholder,
                hintStyle: placeholder != ""
                    ? const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.textDefault,
                      )
                    : const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.disableTextfield,
                      )),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ],
      ),
      // SizedBox(
      //   width: 20,
      // ),
    );
  }

  Widget TextFieldEmail(String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it

            decoration: InputDecoration(
                icon: Poppins(
                    text: "Email         ",
                    size: 14,
                    color: C.dark2,
                    fontWeight: FW.light),
                hintText:
                    placeholder == "" ? "     Email" : "     " + placeholder,
                hintStyle: placeholder != ""
                    ? const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.textDefault,
                      )
                    : const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.disableTextfield,
                      )),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ],
      ),
      // SizedBox(
      //   width: 20,
      // ),
    );
  }

  Widget TextFieldBio(String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            // minLines: 1, //Normal textInputField will be displayed
            maxLines: 5, // when user presses enter it will adapt to it

            decoration: InputDecoration(
                icon: Poppins(
                    text: "Bio              ",
                    size: 14,
                    color: C.dark2,
                    fontWeight: FW.light),
                hintText: placeholder == "" ? "     Bio" : "    " + placeholder,
                hintStyle: placeholder != ""
                    ? const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.textDefault,
                      )
                    : const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FW.light,
                        color: C.disableTextfield,
                      )),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ],
      ),
      // SizedBox(
      //   width: 20,
      // ),
    );
  }
}
