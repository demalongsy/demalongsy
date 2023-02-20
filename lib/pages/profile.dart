import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/pages/post.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/edit_profile.dart';
import 'package:demalongsy/pages/favorite_post.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

class Profile extends StatefulWidget {
  final bool? rootPage;
  const Profile({Key? key, this.rootPage}) : super(key: key);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          widget.rootPage ?? false ? NavigationService.profileKey : null,
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
            backgroundColor: C.white,
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
          child: ExtendedNestedScrollView(
            onlyOneScrollInBody: true,
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      profileHeaderWidget(context),
                    ],
                  ),
                ),
                const SliverAppBar(
                  elevation: 0,
                  backgroundColor: C.white,
                  pinned: true,
                  primary: false,
                  toolbarHeight: 0,
                  bottom: TabBar(
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.0),
                      insets: EdgeInsets.symmetric(horizontal: 80.0),
                    ),
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
                      )
                    ],
                  ),
                )
              ];
            },
            body: const TabBarView(
              children: [PostScreen(), FavoritePosts()],
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
    decoration: const BoxDecoration(color: C.white),
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
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Poppins(
                      text: "K. Payongdech",
                      maxLines: 1,
                      size: 18,
                      color: C.dark1,
                      fontWeight: FW.bold),
                  const SizedBox(
                    height: 10,
                  ),
                  const Poppins(
                      text: "@Dekdee2023_",
                      size: 12,
                      color: C.dark1,
                      fontWeight: FW.light),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Poppins(
                          text: "128 ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FW.bold),
                      Poppins(
                          text: "Posts",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FW.light),
                      SizedBox(
                        width: 12,
                      ),
                      Poppins(
                          text: "12K ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FW.bold),
                      Poppins(
                          text: "Likes ",
                          size: 12,
                          color: C.dark1,
                          fontWeight: FW.light),
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Poppins(
              text:
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula.",
              maxLines: 2,
              size: 14,
              color: C.dark3,
              fontWeight: FW.light),
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
                fontWeight: FW.bold),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(createTransitionRoute(EditProfilePage(), 1, 0));
          },
        ),
      ),
    ],
  );
}
