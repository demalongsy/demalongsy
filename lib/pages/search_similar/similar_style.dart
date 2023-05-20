import 'dart:io';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';

import 'package:demalongsy/custom/widget/font.dart';

class SimilarStylePage extends StatefulWidget {
  final File? image;
  final bool isformPost;
  const SimilarStylePage({Key? key, this.image, required this.isformPost})
      : super(key: key);
  @override
  _SimilarStylePageState createState() => _SimilarStylePageState();
}

class _SimilarStylePageState extends State<SimilarStylePage> {
  // Image

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  // _launchURL() async {
  //   const url = 'https://google.com';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

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
                  child: Container(
                      height: 200,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: widget.isformPost ?? false
                            ? Image.network(
                                "https://s.isanook.com/wo/0/ui/38/190849/277150081_1212531879516407_7579357549109873866_n.jpg?ip/convert/w0/q80/jpg",
                                // fit: BoxFit.cover,
                              )
                            : Image.file(
                                widget.image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),

                        // ClipRRect(
                      )),
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
                              overflow: true,
                              maxLines: 2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
