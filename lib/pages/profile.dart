import 'package:flutter/material.dart';
import 'package:demalongsy/pages/post.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/favorite_post.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: C.primaryDefault,
          elevation: 3,
          child: const Icon(
            Icons.add_rounded,
            size: 48,
            color: C.textDefault,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
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
                Expanded(
                    child: TabBarView(
                  children: [PostScreen(), FavoritePosts()],
                ))
              ],
            ),
          ),
        ),
      )),
    );
  }
}

Widget profileHeaderWidget(BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: const BoxDecoration(color: Colors.white),
    child: Padding(
      padding: const EdgeInsets.only(left: 38, right: 38),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xff74EDED),
                backgroundImage:
                    NetworkImage("https://placeimg.com/640/480/people"),
              ),
              const SizedBox(
                width: 28,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Poppins(
                      text: "K. Payongdech",
                      size: 18,
                      color: C.dark1,
                      fontWeight: FontWeight.w700),
                  const SizedBox(
                    height: 10,
                  ),
                  const Poppins(
                      text: "@Dekdee2023_",
                      size: 12,
                      color: C.dark1,
                      fontWeight: FontWeight.w400),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Poppins(
                          text: "128 ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w700),
                      Poppins(
                          text: "Posts",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w400),
                      SizedBox(
                        width: 12,
                      ),
                      Poppins(
                          text: "12K ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w700),
                      Poppins(
                          text: "Likes ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Poppins(
              text: "Fantastic to start to use application!",
              size: 14,
              color: C.dark3,
              fontWeight: FontWeight.w400),
          const SizedBox(
            height: 12,
          ),
          actions(context),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    ),
  );
}

Widget actions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
                  primary: C.secondaryDefault, // Background color
                  onPrimary:
                      C.secondaryPressed, // Text Color (Foreground color)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 0.0,
                  shadowColor: Colors.transparent)
              .copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Poppins(
                text: "Edit Profile",
                size: 12,
                color: C.dark1,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () {},
        ),
      ),
    ],
  );
}
