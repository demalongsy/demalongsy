import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/pages/post/create_post.dart';
import 'package:demalongsy/pages/profile/change_password.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/profile/post.dart';
import 'package:demalongsy/pages/auth/login.dart';
import 'package:demalongsy/pages/profile/policy.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/pages/profile/feedback.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/profile/edit_profile.dart';
import 'package:demalongsy/pages/profile/favorite_post.dart';
import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:demalongsy/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final bool? isRootPage;
  final bool? isOwner;

  const Profile({Key? key, this.isRootPage, this.isOwner = false})
      : super(key: key);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  ProfileApi? _data;

  bool isPoptoRoot = false;

  bool isLoading = true;

  Future<ProfileApi?> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      var url = '${Url.baseurl}/profile/${username}';
      ;

      var response = await http.get(Uri.parse(url));

      _data = profileApiFromJson(response.body);
      return _data;
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: (widget.isRootPage ?? false || isPoptoRoot)
          ? NavigationService.profileKey
          : null,
      home: SafeArea(
          child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true)
                .push(createTransitionRoute(CreatePost(), 1, 0));
          },
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.isRootPage ?? false
                    ? const Expanded(child: SizedBox())
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: C.dark2,
                          size: 20.0,
                        ),
                      ),
                (widget.isRootPage == true && widget.isOwner == true)
                    ? GestureDetector(
                        child: const Icon(
                          Icons.settings_outlined,
                          color: Colors.black,
                        ),
                        onTap: () {
                          showModalBottomSheet<void>(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            context: context,
                            useRootNavigator: true,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  SvgPicture.asset(
                                    "assets/images/line.svg",
                                    width: 8,
                                    height: 4,
                                    color: C.dark2,
                                  ),
                                  const SizedBox(height: 10),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Poppins(
                                        text: "Setting",
                                        size: 18,
                                        color: C.dark1,
                                        fontWeight: FW.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/images/lock-solid.svg",
                                        width: 23,
                                        height: 23,
                                        color: C.dark2,
                                      ),
                                      title: const Poppins(
                                          text: "Change Password",
                                          size: 16,
                                          color: C.dark2,
                                          fontWeight: FW.light),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(microseconds: 0));
                                        await Navigator.of(context,
                                                rootNavigator: true)
                                            .push(createTransitionRoute(
                                                ChangePasswordPage(), 1, 0));
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 80, right: 70),
                                    child: Divider(
                                      color: C.darkHover,
                                      thickness: 2,
                                      // height: 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/images/policy-solid.svg",
                                        width: 23,
                                        height: 23,
                                        color: C.dark2,
                                      ),
                                      title: const Poppins(
                                          text: "Policy",
                                          size: 16,
                                          color: C.dark2,
                                          fontWeight: FW.light),
                                      onTap: () async {
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(microseconds: 0));
                                        await Navigator.of(context,
                                                rootNavigator: true)
                                            .push(createTransitionRoute(
                                                PolicyPage(), 0, 1));
                                      },
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 80, right: 70),
                                    child: Divider(
                                      color: C.darkHover,
                                      thickness: 2,
                                      // height: 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: ListTile(
                                      leading: SvgPicture.asset(
                                        "assets/images/message-solid.svg",
                                        width: 23,
                                        height: 23,
                                        color: C.dark2,
                                      ),
                                      title: const Poppins(
                                          text: "Feedback",
                                          size: 16,
                                          color: C.dark2,
                                          fontWeight: FW.light),
                                      onTap: () async {
                                        SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();

                                        final String? user_id =
                                            prefs.getString('user_id');
                                        Navigator.pop(context);
                                        Future.delayed(
                                            Duration(microseconds: 0));
                                        await Navigator.of(context,
                                                rootNavigator: true)
                                            .push(createTransitionRoute(
                                                FeedBack(
                                                    name: _data?.name,
                                                    username: _data?.username),
                                                1,
                                                0));
                                      },
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(bottom: 20)),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(color: C.dark2),
                                      primary: C.dark3, // Background color
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 130, vertical: 10),
                                      child: Poppins(
                                          text: "Log Out",
                                          size: 16,
                                          color: C.dark2,
                                          fontWeight: FW.bold),
                                    ),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      Future.delayed(Duration(microseconds: 0));
                                      await showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              title: Column(
                                                children: const [
                                                  Roboto(
                                                    text: "Are you sure to",
                                                    size: 20,
                                                    color: C.dark2,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Roboto(
                                                    text: "Log out?",
                                                    size: 20,
                                                    color: C.dark2,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                // The "No" button
                                                CupertinoDialogAction(
                                                  onPressed: () {
                                                    setState(() {
                                                      isPoptoRoot = true;
                                                    });
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Poppins(
                                                      text: "No",
                                                      size: 16,
                                                      color: C.dangerDefault,
                                                      fontWeight: FW.bold),
                                                ),
                                                // The "Yes" button
                                                CupertinoDialogAction(
                                                  onPressed: () async {
                                                    SharedPreferences prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    await prefs.remove('token');
                                                    await prefs
                                                        .remove('user_id');
                                                    await prefs
                                                        .remove('username');

                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Login()),
                                                        (route) => false);
                                                  },
                                                  child: const Poppins(
                                                      text: "Yes",
                                                      size: 16,
                                                      color: C.infoDefault,
                                                      fontWeight: FW.bold),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              );
                            },
                          );
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ),
        body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var result = snapshot.data;
              return DefaultTabController(
                length: 2,
                child: ExtendedNestedScrollView(
                  onlyOneScrollInBody: true,
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            profileHeaderWidget(
                              context,
                              (result.name).toString(),
                              (result.username).toString(),
                              (result.numWasLiked).toString(),
                              (result.numPostes).toString(),
                              (result.bio ?? "Welcome to De'malongsy!")
                                  .toString(),
                              (result.img ??
                                      "https://img.freepik.com/free-icon/user_318-159711.jpg")
                                  .toString(),
                            ),
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
              );
            }
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset(
                  "assets/images/loading.gif",
                  height: 45,
                  width: 45,
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  Widget profileHeaderWidget(BuildContext context, String name, String username,
      String numLiked, String numPosted, String bio, String img) {
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
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xff74EDED),
                  backgroundImage: NetworkImage(img),
                ),
                const SizedBox(
                  width: 28,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Poppins(
                        text: name,
                        maxLines: 1,
                        size: 18,
                        color: C.dark1,
                        fontWeight: FW.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    Poppins(
                        text: "@" + username,
                        size: 12,
                        color: C.dark1,
                        fontWeight: FW.light),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Poppins(
                            text: "${numPosted} ",
                            size: 12,
                            color: C.dark1,
                            fontWeight: FW.bold),
                        const Poppins(
                            text: "Posts",
                            size: 12,
                            color: C.dark1,
                            fontWeight: FW.light),
                        const SizedBox(
                          width: 12,
                        ),
                        Poppins(
                            text: "${numLiked} ",
                            size: 12,
                            color: C.dark1,
                            fontWeight: FW.bold),
                        const Poppins(
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
            Poppins(
                text: bio,
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
}

Widget actions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
                  primary: C.secondaryDefault,
                  onPrimary: C.secondaryPressed,
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
