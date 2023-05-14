import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:demalongsy/custom/widget/font.dart';

class SuggestStylePage extends StatefulWidget {
  @override
  _SuggestStylePageState createState() => _SuggestStylePageState();
}

class _SuggestStylePageState extends State<SuggestStylePage> {
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

  _launchURL() async {
    const url = 'https://google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                        text: "Similar Items",
                        size: 20,
                        color: C.dark1,
                        fontWeight: FW.bold,
                        letterspacing: 0.64,
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 160,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Poppins(
                    text: "Your similar items list",
                    size: 12,
                    color: C.textDefault,
                    fontWeight: FW.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 115,
                      height: 115,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        // shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: C.secondaryDefault,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 3, bottom: 3),
                              child: Poppins(
                                text: "Givenchy",
                                size: 18,
                                color: C.textDefault,
                                fontWeight: FW.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Poppins(
                              overflow: false,
                              text:
                                  "Silk women pants inspire from 90s styleeeeeeeeeeeeeeee",
                              size: 12,
                              color: C.textDefault,
                              fontWeight: FW.light,
                              letterspacing: 0.64,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Poppins(
                    text: "Suggest items",
                    size: 12,
                    color: C.textDefault,
                    fontWeight: FW.bold,
                  ),
                ),
                const Divider(
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      // imageList.length + 1 > 10 ? 10 : imageList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.height * 0.17,
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.115,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Poppins(
                                            overflow: true,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            text: "Denim casual pants",
                                            size: 12,
                                            color: C.textDefault,
                                            fontWeight: FW.light,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
