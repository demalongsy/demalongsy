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
          backgroundColor: C.primaryDefault,
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
                          child: Poppins(
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
            // padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  // Text(
                  //   "Edit Profile",
                  //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                  ))),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("Full Name", "Dor Alex", false),
                  buildTextField("E-mail", "alexd@gmail.com", false),
                  buildTextField("Password", "********", true),
                  buildTextField("Location", "TLV, Israel", false),
                  SizedBox(
                    height: 35,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     OutlineButton(
                  //       padding: EdgeInsets.symmetric(horizontal: 50),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20)),
                  //       onPressed: () {},
                  //       child: Text("CANCEL",
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               letterSpacing: 2.2,
                  //               color: Colors.black)),
                  //     ),
                  //     RaisedButton(
                  //       onPressed: () {},
                  //       color: Colors.green,
                  //       padding: EdgeInsets.symmetric(horizontal: 50),
                  //       elevation: 2,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(20)),
                  //       child: Text(
                  //         "SAVE",
                  //         style: TextStyle(
                  //             fontSize: 14,
                  //             letterSpacing: 2.2,
                  //             color: Colors.white),
                  //       ),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
