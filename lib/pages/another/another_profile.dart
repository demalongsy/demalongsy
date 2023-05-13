import 'package:demalongsy/base_URL/url.dart';
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
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:demalongsy/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnotherProfile extends StatefulWidget {
  final bool? isRootPage;
  final bool? isOwner;
  final String another_username;
  final String another_id;

  const AnotherProfile(
      {Key? key,
      this.isRootPage,
      this.isOwner = false,
      required this.another_username,
      required this.another_id})
      : super(key: key);
  @override
  _AnotherProfile createState() => _AnotherProfile();
}

class _AnotherProfile extends State<AnotherProfile> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isPoptoRoot = false;
  bool isLoading = true;
  ProfileApi? _data;
  List<Map<String, dynamic>> allPost = [];
  List<Map<String, dynamic>> dataLikedPosts = [];

  Future<void> _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');
      final String? token = prefs.getString('token');

      var url =
          '${Url.baseurl}/profile/${username}?another_username=${widget.another_username}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.get(Uri.parse(url), headers: header);

      _data = profileApiFromJson(response.body);
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future<void> _getDataPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('user_id');

    setState(() {
      allPost.clear();
    });

    var url =
        '${Url.baseurl}/profile/viewprofile/post?user_id=${user_id}&another_id=${widget.another_id}';

    var response = await http.get(Uri.parse(url));

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

    var url =
        '${Url.baseurl}/profile/viewprofile/liked?user_id=${user_id}&another_id=${widget.another_id}';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var _data = convert.jsonDecode(response.body);

      (_data["data"] as List).map((e) => dataLikedPosts.add(e)).toList();

      setState(() {
        isLoading = false;
      });
    } else {
      print('err ==> ${response.statusCode}');
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

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                    ? SizedBox()
                    : SizedBox()
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
                              return ShowPost(
                                  topic: allPost[index]["title"],
                                  name: allPost[index]["name"],
                                  imgAcc: allPost[index]["imgAuthor"],
                                  imgPath: allPost[index]["images"][0],
                                  isLiked: allPost[index]["isLiked"],
                                  block_id: allPost[index]["id"],
                                  author_id: allPost[index][" author_id"],
                                  tags: allPost[index]["tags"],
                                  author_username: allPost[index]["username"],
                                  imgAuthor: allPost[index]["imgAuthor"]);
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
                              return ShowPost(
                                  topic: dataLikedPosts[index]["title"],
                                  name: dataLikedPosts[index]["name"],
                                  imgAcc: dataLikedPosts[index]["imgAuthor"],
                                  imgPath: dataLikedPosts[index]["images"][0],
                                  isLiked: dataLikedPosts[index]["isLiked"],
                                  block_id: dataLikedPosts[index]["id"],
                                  author_id: dataLikedPosts[index]
                                      [" author_id"],
                                  tags: dataLikedPosts[index]["tags"],
                                  author_username: dataLikedPosts[index]
                                      ["username"],
                                  imgAuthor: dataLikedPosts[index]
                                      ["imgAuthor"]);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      )),
    );
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
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xff74EDED),
                  backgroundImage: NetworkImage(_data?.img ??
                      "https://img.freepik.com/free-icon/user_318-159711.jpg"),
                ),
                const SizedBox(
                  width: 28,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Poppins(
                        text: _data!.name!.toString(),
                        maxLines: 1,
                        size: 18,
                        color: C.dark1,
                        fontWeight: FW.bold),
                    const SizedBox(
                      height: 10,
                    ),
                    Poppins(
                        text: "@" + _data!.username!.toString(),
                        size: 12,
                        color: C.dark1,
                        fontWeight: FW.light),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Poppins(
                            text: "${_data!.numPostes.toString()} ",
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
                            text: "${_data!.numWasLiked.toString()} ",
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
            Poppins(
                text: _data!.bio ?? "Welcome to De'malongsy!",
                maxLines: 2,
                size: 14,
                color: C.dark3,
                fontWeight: FW.light),
            const SizedBox(
              height: 12,
            ),
            _data!.isOwner! ? actions(context) : Container(),
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
