import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              onPressed: () => print("Add"),
            )
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    profileHeaderWidget(context),
                  ],
                ),
              ),
            ];
          },
          body: Column(
            children: const <Widget>[
              Material(
                color: Colors.white,
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0),
                    insets: EdgeInsets.symmetric(horizontal: 70.0),
                  ),
                  // padding: EdgeInsets.only(left: 50, right: 50),
                  // indicator: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Colors.green,
                  //       Colors.blue,
                  //       Colors.red,
                  //     ],
                  //   ),
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(4),
                  //   ),
                  // ),
                  // indicatorWeight: 10,
                  // indicatorPadding: EdgeInsets.only(top: 50),
                  // indicatorColor: Colors.black,
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.window,
                        color: C.dark1,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
