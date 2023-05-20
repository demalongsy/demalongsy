import 'dart:io';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:demalongsy/custom/widget/font.dart';

class SuggestStylePage extends StatefulWidget {
  const SuggestStylePage({Key? key}) : super(key: key);
  @override
  _SuggestStylePageState createState() => _SuggestStylePageState();
}

class _SuggestStylePageState extends State<SuggestStylePage> {
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
                        text: "Suggest Items",
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
                  height: 24,
                ),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 2),
                      child: Poppins(
                        text: "Category:",
                        size: 14,
                        color: C.textDefault2,
                        fontWeight: FW.regular,
                        letterspacing: 0.4,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Wrap(
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
                              text: "T-shirt / haut",
                              size: 13,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: C.secondaryDefault,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 3, bottom: 3),
                            child: Poppins(
                              text: "Ankle boot",
                              size: 13,
                              color: C.textDefault,
                              fontWeight: FW.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Row(
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
                                const Padding(
                                  padding: EdgeInsets.only(right: 8, bottom: 3),
                                  child: Poppins(
                                    text: "Givenchy",
                                    size: 18,
                                    color: C.textDefault,
                                    fontWeight: FW.bold,
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
                                        "Silk women pants inspire from 90s styleeeeeeee",
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
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
