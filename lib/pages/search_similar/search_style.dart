import 'dart:io';
import 'dart:async';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/main.dart';
import 'package:demalongsy/pages/search_similar/suggest_style.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class SearchStylePage extends StatefulWidget {
  @override
  _SearchStylePageState createState() => _SearchStylePageState();
}

class _SearchStylePageState extends State<SearchStylePage> {
  // Image
  File? image;

  Future takePhoto(ImageSource source) async {
    try {
      final _picker = ImagePicker();
      final image = await _picker.pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: C.primaryDefault,
          body: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                // profilePhoto(),
                Container(
                  alignment: Alignment.center,
                  child: const Spectral(
                      text: "Get to know!",
                      letterspacing: 0.64,
                      size: 32,
                      color: C.dark1,
                      fontWeight: FW.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  "assets/images/svg-similar-page.svg",
                  width: 180,
                  height: 180,
                  // fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: C.dark1,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: C.secondaryDefault,
                                      borderRadius: BorderRadius.circular(50),
                                      border:
                                          Border.all(width: 1, color: C.dark2),
                                    ),
                                    height: 25,
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 2,
                                          bottom: 2,
                                          right: 12,
                                          left: 12),
                                      child: Poppins(
                                          text: "#Similar Products",
                                          size: 14,
                                          color: C.textDefault,
                                          fontWeight: FW.light),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                const Poppins(
                                  textAlign: TextAlign.center,
                                  text:
                                      "One cool feature that We suggest is \n the ability to recommend similar \n products  and their sources.",
                                  size: 14,
                                  color: C.disableTextfield,
                                  fontWeight: FW.light,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                const Poppins(
                                  textAlign: TextAlign.center,
                                  text: "Ready? Let’s get start below.",
                                  size: 14,
                                  color: C.secondaryDefault,
                                  fontWeight: FW.light,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: C.white, // Background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: const Center(
                                        child: Poppins(
                                            text: "Album",
                                            size: 16,
                                            color: C.dark2,
                                            fontWeight: FW.bold),
                                      ),
                                      onPressed: () async {
                                        Future.delayed(Duration(seconds: 5));
                                        // Navigator.of(context).pop();
                                        await takePhoto(ImageSource.gallery);
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(createTransitionRoute(
                                                SuggestStylePage(), 1, 0));
                                      },
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: C.white, // Background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                          ),
                                          elevation: 0.0,
                                          shadowColor: Colors.transparent),
                                      child: const Center(
                                        child: Poppins(
                                            text: "Camera",
                                            size: 16,
                                            color: C.dark2,
                                            fontWeight: FW.bold),
                                      ),
                                      onPressed: () async {
                                        Future.delayed(Duration(seconds: 5));
                                        // Navigator.of(context).pop();
                                        await takePhoto(ImageSource.camera);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: C.primaryDefault, spreadRadius: 10),
                          ],
                          borderRadius: BorderRadius.circular(50),
                          color: C.dark1,
                        ),
                        width: 60,
                        height: 60,
                        child: SvgPicture.asset(
                          "assets/images/laundrySimilar.svg",
                          width: 20,
                          height: 20,
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
