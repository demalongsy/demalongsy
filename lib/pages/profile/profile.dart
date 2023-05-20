import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/pages/comments/view_comment.dart';
import 'package:demalongsy/pages/post/create_post.dart';
import 'package:demalongsy/pages/post/post_foryou.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:demalongsy/pages/profile/change_password.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/auth/login.dart';
import 'package:demalongsy/pages/profile/policy.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/pages/profile/feedback.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/profile/edit_profile.dart';

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
  final String? username;

  const Profile(
      {Key? key, this.isRootPage, this.isOwner = false, this.username})
      : super(key: key);
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ProfileApi? _data;
  List<Map<String, dynamic>> allPost = [];
  List<Map<String, dynamic>> dataLikedPosts = [];

  bool isPoptoRoot = false;

  bool isLoading = true;

  Future<ProfileApi?> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      var url = '${Url.baseurl}/profile/${username}';

      var response = await http.get(Uri.parse(url));

      _data = profileApiFromJson(response.body);
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future<void> _getDataPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('user_id');

    var url = '${Url.baseurl}/profile/viewprofile/post?user_id=${user_id}';

    var response = await http.get(Uri.parse(url));
    setState(() {
      allPost.clear();
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      var _data = convert.jsonDecode(response.body);

      (_data["data"] as List).map((e) => allPost.add(e)).toList();
    } else {
      print('err ==> ${response.statusCode}');
    }
  }

  Future<void> _getDataLikedPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('user_id');
    setState(() {
      dataLikedPosts.clear();
    });

    var url = '${Url.baseurl}/profile/viewprofile/liked?user_id=${user_id}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var _data = convert.jsonDecode(response.body);

      (_data["data"] as List).map((e) => dataLikedPosts.add(e)).toList();
    }
  }

  Future<void> _refresh() async {
    await _getData();
    await _getDataPost();
    await _getDataLikedPosts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _refresh();
    setState(() {});

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    .push(createTransitionRoute(CreatePost(), 1, 0))
                    .then((val) => val ? _refresh() : null);
                ;
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
                                                    ChangePasswordPage(),
                                                    1,
                                                    0));
                                          },
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 80, right: 70),
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
                                        padding: EdgeInsets.only(
                                            left: 80, right: 70),
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
                                                        username:
                                                            _data?.username),
                                                    1,
                                                    0));
                                          },
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(bottom: 20)),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side:
                                              const BorderSide(color: C.dark2),
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
                                          Future.delayed(
                                              Duration(microseconds: 0));
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Poppins(
                                                          text: "No",
                                                          size: 16,
                                                          color:
                                                              C.dangerDefault,
                                                          fontWeight: FW.bold),
                                                    ),
                                                    // The "Yes" button
                                                    CupertinoDialogAction(
                                                      onPressed: () async {
                                                        SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await prefs
                                                            .remove('token');
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
            body: isLoading
                ? Center(
                    child: Image.asset(
                      "assets/images/loading.gif",
                      height: 48,
                      width: 48,
                    ),
                  )
                : RefreshIndicator(
                    color: C.primaryDefault,
                    backgroundColor: C.white,
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: DefaultTabController(
                      length: 2,
                      child: NestedScrollView(
                        physics: BouncingScrollPhysics(),
                        headerSliverBuilder: (context, _) {
                          return [
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  profileHeaderWidget(
                                    context,
                                    (_data?.name).toString(),
                                    (_data?.username).toString(),
                                    (_data?.numWasLiked).toString(),
                                    (_data?.numPostes).toString(),
                                    (_data?.bio ?? "Welcome to De'malongsy!")
                                        .toString(),
                                    (_data?.imgAuthor ??
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
                              toolbarHeight: 0,
                              bottom: TabBar(
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(width: 2.0),
                                  insets:
                                      EdgeInsets.symmetric(horizontal: 80.0),
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
                        body: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        mainAxisExtent: 298,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6),
                                itemCount: allPost.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                      onTap: (() {
                                        _refresh();
                                        Navigator.of(context,
                                                rootNavigator: false)
                                            .push(createTransitionRoute(
                                                ViewPost(
                                                    tags: allPost[index]
                                                        ["tags"],
                                                    block_id: allPost[index]
                                                        ["id"],
                                                    author_username:
                                                        allPost[index]
                                                            ["username"],
                                                    imgAuthor: allPost[index]
                                                        ["imgAuthor"]),
                                                1,
                                                0));
                                      }),
                                      child: Container(
                                        height: 289,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 20,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: C.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Stack(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                height: 198,
                                                //width: 168,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          allPost[index]
                                                              ["images"][0]),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Container(
                                                height: 57,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Poppins(
                                                    text: allPost[index]
                                                        ["title"],
                                                    size: 14,
                                                    color: C.dark1,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                    maxLines: 2,
                                                    fontRespon: false,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Color(0xff74EDED),
                                                      backgroundImage:
                                                          NetworkImage(allPost[
                                                                  index]
                                                              ["imgAuthor"]),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Poppins(
                                                      text: allPost[index]
                                                          ["name"],
                                                      size: 10,
                                                      color: C.dark1,
                                                      fontWeight: FW.regular,
                                                      letterspacing: 0.64,
                                                      maxLines: 1,
                                                      fontRespon: false,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 168,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Expanded(child: Container()),
                                                  allPost[index]["isLiked"]
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            await _unlikesPost(
                                                                allPost[index]
                                                                    ["id"]);
                                                            _refresh();
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: C.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: const Icon(
                                                              Icons.favorite,
                                                              color: C.dark1,
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () async {
                                                            await _likesPost(
                                                                allPost[index]
                                                                    ["id"]);
                                                            _refresh();
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: C.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .favorite_outline_rounded,
                                                              color: C.dark1,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      ));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        mainAxisExtent: 298,
                                        crossAxisSpacing: 6,
                                        mainAxisSpacing: 6),
                                itemCount: dataLikedPosts.length,
                                itemBuilder: (BuildContext context, index) {
                                  return GestureDetector(
                                      onTap: (() {
                                        _refresh();
                                        Navigator.of(context,
                                                rootNavigator: false)
                                            .push(createTransitionRoute(
                                                ViewPost(
                                                    tags: dataLikedPosts[index]
                                                        ["tags"],
                                                    block_id:
                                                        dataLikedPosts[index]
                                                            ["id"],
                                                    author_username:
                                                        dataLikedPosts[index]
                                                            ["username"],
                                                    imgAuthor:
                                                        dataLikedPosts[index]
                                                            ["imgAuthor"]),
                                                1,
                                                0))
                                            .then((val) =>
                                                val ? _refresh() : _refresh());
                                      }),
                                      child: Container(
                                        height: 289,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 20,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                            color: C.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Stack(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                height: 198,
                                                //width: 168,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  8),
                                                          topLeft:
                                                              Radius.circular(
                                                                  8)),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          dataLikedPosts[index]
                                                              ["images"][0]),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Container(
                                                height: 57,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(7.0),
                                                  child: Poppins(
                                                    text: dataLikedPosts[index]
                                                        ["title"],
                                                    size: 14,
                                                    color: C.dark1,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                    maxLines: 2,
                                                    fontRespon: false,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 7),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Color(0xff74EDED),
                                                      backgroundImage:
                                                          NetworkImage(
                                                              dataLikedPosts[
                                                                      index][
                                                                  "imgAuthor"]),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Poppins(
                                                      text:
                                                          dataLikedPosts[index]
                                                              ["name"],
                                                      size: 10,
                                                      color: C.dark1,
                                                      fontWeight: FW.regular,
                                                      letterspacing: 0.64,
                                                      maxLines: 1,
                                                      fontRespon: false,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: 168,
                                              height: 40,
                                              child: Row(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Expanded(child: Container()),
                                                  dataLikedPosts[index]
                                                          ["isLiked"]
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            await _unlikesPost(
                                                                dataLikedPosts[
                                                                        index]
                                                                    ["id"]);
                                                            _refresh();
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: C.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: const Icon(
                                                              Icons.favorite,
                                                              color: C.dark1,
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () async {
                                                            await _likesPost(
                                                                dataLikedPosts[
                                                                        index]
                                                                    ["id"]);
                                                            _refresh();
                                                          },
                                                          child: Container(
                                                            height: 32,
                                                            width: 32,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: C.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: const Icon(
                                                              Icons
                                                                  .favorite_outline_rounded,
                                                              color: C.dark1,
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ));
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
                  .push(createTransitionRoute(EditProfilePage(), 1, 0))
                  .then((val) => val ? _refresh() : null);
              ;
            },
          ),
        ),
      ],
    );
  }

  _likesPost(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/liked/?block_id=${id}&user_id=${user_id}';
      print(url);

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.patch(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("success");
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  _unlikesPost(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/unliked/?block_id=${id}&user_id=${user_id}';
      print(url);

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.patch(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("success");
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
