import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../custom/toolkit.dart';

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

  void _handleTabSelection() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return SafeArea(
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 54),
            child: Column(
              children: [
                const TabBar(
                    // controller: controller,
                    labelColor: Colors.black,
                    // labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0),
                      insets:
                          EdgeInsets.symmetric(horizontal: 90.0, vertical: 0),
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
                    Container(
                      child: Center(
                        child: Text("1st tab"),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Text("2nd tab"),
                      ),
                    )
                  ]),
                )
              ],
            ),
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
    );
  }
}
