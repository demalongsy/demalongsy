import 'dart:math';
import '../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demalongsy/pages/searchPost.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:demalongsy/pages/searchAccount.dart';
import 'package:demalongsy/custom/widget/component.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // late TabController controller;
  @override
  // initState() {
  //   super.initState();
  //   controller = new TabController(vsync: this, length: 2);
  //   controller.addListener(_handleTabSelection);
  // }

  // void _handleTabSelection() {
  //   setState(() {});
  // }

  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: C.backgroundWhiteIvory,
            appBar: AppBar(
              backgroundColor: C.backgroundWhiteIvory,
              elevation: 0.0,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: const InputField(
                    color: C.disableTextfield,
                    text: 'Search',
                    size: 16,

                    // boxHeight: 40,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                const TabBar(
                    // controller: controller,
                    labelColor: Colors.black,
                    // labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0),
                      insets:
                          EdgeInsets.symmetric(horizontal: 84.0, vertical: 0),
                    ),
                    indicatorColor: C.dark1,
                    labelStyle: TextStyle(fontWeight: FW.bold, fontSize: 14),
                    tabs: [
                      Tab(
                        // icon: Icon(Icons.home),
                        text: "Post",
                      ),
                      Tab(
                        text: "Account",
                      )
                    ]),
                Expanded(
                  child: TabBarView(children: [
                    //post
                    SearchPost(),
                    //account
                    SearchAccount()
                  ]),
                )
              ],
            ),
            // body: Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(23.0),
            //     // child: Column(
            //     //   // ignore: prefer_const_literals_to_create_immutables
            //     //   children: [
            //     //     const InputField(
            //     //       // color: C.disableTextfield,
            //     //       text: 'Search',
            //     //       size: 16,
            //     //     )
            //     //   ],
            //     // ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
