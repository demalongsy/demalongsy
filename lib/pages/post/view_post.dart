import 'dart:ui';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/another/another_profile.dart';
import 'package:demalongsy/pages/comments/view_comment.dart';
import 'package:demalongsy/pages/search_similar/similar_style.dart';
import 'package:demalongsy/pages/suggest/suggest_style.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:demalongsy/models/view_post.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ViewPost extends StatefulWidget {
  final List<dynamic> tags;
  final String author_username;
  final String block_id;
  final String imgAuthor;
  final int = 0;
  const ViewPost(
      {Key? key,
      required this.tags,
      required this.block_id,
      required this.author_username,
      required this.imgAuthor})
      : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  ViewPostDetail? _postDetail;
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> filedata = [];
  bool isLoading = true;
  bool isLoadingPost = true;
  int numLiked = 0;
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  bool isDeleted = false;
  bool isFavorited = false;
  String? usrname;
  String? month;
  String? date;

  Future<void> _refresh() async {
    await _getData();
    await _getPostDetail();
    await _getComments();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _refresh();
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
            backgroundColor: C.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                backgroundColor: C.white,
                elevation: 0,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: C.dark2,
                        size: 16.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: false).push(
                              createTransitionRoute(
                                  AnotherProfile(
                                      another_username: _postDetail!.username!,
                                      another_id: _postDetail!.authorId!),
                                  1,
                                  0));
                        },
                        child: Container(
                          // color: C.dangerDefault,
                          width: 40,
                          height: 40,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(widget.imgAuthor),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: false).push(
                                  createTransitionRoute(
                                      AnotherProfile(
                                          another_username:
                                              _postDetail!.username!,
                                          another_id: _postDetail!.authorId!),
                                      1,
                                      0));
                            },
                            child: Poppins(
                              text: isLoadingPost == true
                                  ? "..."
                                  : _postDetail!.name!,
                              size: 14,
                              maxLines: 1,
                              overflow: true,
                              color: C.dark1,
                              fontWeight: FW.bold,
                              letterspacing: 0.64,
                            ),
                          ),
                        ),
                      ),
                    ),
                    widget.author_username == usrname
                        ? GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
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
                                      const SizedBox(height: 24),
                                      SvgPicture.asset(
                                        "assets/images/line.svg",
                                        width: 8,
                                        height: 4,
                                        color: C.dark2,
                                      ),
                                      const SizedBox(height: 24),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: GestureDetector(
                                          child: const Button(
                                            text: 'Delete Post',
                                            size: 16,
                                            hasImg: true,
                                            pathImg:
                                                "assets/images/trash-dark.svg",
                                            color: C.dark1,
                                            fontWeight: FW.regular,
                                            customRadius: true,
                                            radius: 8,
                                            boxColor: C.boderAddPhotos,
                                            boxHeight: 56,
                                          ),
                                          onTap: () async {
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
                                                        text: "delete post?",
                                                        size: 20,
                                                        color: C.dark2,
                                                        fontWeight: FW.bold,
                                                        letterspacing: 0.64,
                                                      ),
                                                    ],
                                                  ),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      onPressed: () {
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
                                                    CupertinoDialogAction(
                                                      onPressed: () async {
                                                        await _deletePost(
                                                            _postDetail!
                                                                .blockId!);
                                                        setState(() {
                                                          isDeleted = true;
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Poppins(
                                                          text: "Yes",
                                                          size: 16,
                                                          color: C.infoDefault,
                                                          fontWeight: FW.bold),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 32),
                                    ],
                                  );
                                },
                              );
                            },
                            child: isDeleted == false
                                ? const Icon(
                                    Icons.more_horiz,
                                    color: C.dark2,
                                    size: 24.0,
                                  )
                                : Container(),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            body: isDeleted == false
                ? isLoading
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              isLoadingPost == true
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: Image.asset(
                                          "assets/images/loading.gif",
                                          height: 45,
                                          width: 45,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                // height: 460,
                                                child: CarouselSlider(
                                                  items: _postDetail!.images!
                                                      .map(
                                                        (item) => Image.network(
                                                          item,
                                                          fit: BoxFit.fill,
                                                          width:
                                                              double.infinity,
                                                          // height: 500,
                                                        ),
                                                      )
                                                      .toList(),
                                                  carouselController:
                                                      _carouselController,
                                                  options: CarouselOptions(
                                                    height: 460,
                                                    scrollPhysics:
                                                        const BouncingScrollPhysics(),
                                                    autoPlay: false,
                                                    aspectRatio: 2,
                                                    viewportFraction: 1,
                                                    onPageChanged:
                                                        ((index, reason) {
                                                      setState(
                                                        () {
                                                          currentIndex = index;
                                                        },
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              left: 0,
                                              right: 0,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: _postDetail!.images!
                                                    .asMap()
                                                    .entries
                                                    .map(
                                                  (entry) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          _carouselController
                                                              .animateToPage(
                                                                  entry.key),
                                                      child: Container(
                                                        width: currentIndex ==
                                                                entry.key
                                                            ? 7
                                                            : 7,
                                                        height: 7.0,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 3.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: currentIndex ==
                                                                    entry.key
                                                                ? C.secondaryDefault
                                                                : C.disableBackground),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                            Positioned(
                                              top: 16,
                                              right: 16,
                                              child: Container(
                                                width: 44,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: C.dark3,
                                                ),
                                                child: Center(
                                                  child: Poppins(
                                                      text:
                                                          '${currentIndex + 1}/${_postDetail?.images?.length}',
                                                      size: 14,
                                                      color: C.white,
                                                      fontWeight: FW.regular),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 12),
                                              // height: 36,
                                              child: Row(
                                                children: [
                                                  isFavorited
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            await _unlikesPost();
                                                            setState(
                                                              () {
                                                                numLiked -= 1;
                                                                isFavorited =
                                                                    false;
                                                              },
                                                            );
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
                                                              size: 24,
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () async {
                                                            await _likesPost();
                                                            setState(() {
                                                              isFavorited =
                                                                  true;
                                                              numLiked += 1;
                                                            });
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
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ),
                                                  Poppins(
                                                    text: numLiked.toString(),
                                                    size: 14,
                                                    maxLines: 1,
                                                    overflow: true,
                                                    color: C.dark1,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                            createTransitionRoute(
                                                                ViewComment(
                                                                  block_id: widget
                                                                      .block_id,
                                                                  imgAuthor: widget
                                                                      .imgAuthor,
                                                                  name:
                                                                      _postDetail!
                                                                          .name!,
                                                                ),
                                                                1,
                                                                0),
                                                          )
                                                          .then((val) => val
                                                              ? _refresh()
                                                              : null);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12),
                                                      decoration: BoxDecoration(
                                                        color: C.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: SvgPicture.asset(
                                                        'assets/images/message_filled.svg',
                                                        width: 24,
                                                        height: 24,
                                                      ),
                                                    ),
                                                  ),
                                                  Poppins(
                                                    text: _postDetail!
                                                        .numComment!
                                                        .toString(),
                                                    size: 14,
                                                    maxLines: 1,
                                                    overflow: true,
                                                    color: C.dark1,
                                                    fontWeight: FW.bold,
                                                    letterspacing: 0.64,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  decoration: BoxDecoration(
                                                    color: C.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Poppins(
                                                  overflow: false,
                                                  text: _postDetail!.title!,
                                                  size: 18,
                                                  color: C.dark2,
                                                  fontWeight: FW.bold),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              margin: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Poppins(
                                                overflow: false,
                                                text: _postDetail!.desc!,
                                                size: 14,
                                                color: C.dark1,
                                                fontWeight: FW.regular,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Wrap(
                                                  children: _postDetail!.tags!
                                                      .map(
                                                        (val) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 4,
                                                                  right: 4),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 2,
                                                                    horizontal:
                                                                        8),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: C
                                                                  .secondaryDefault,
                                                            ),
                                                            height: 24,
                                                            child: Poppins(
                                                              overflow: false,
                                                              text: '#${val}',
                                                              size: 14,
                                                              color: C.dark3,
                                                              fontWeight:
                                                                  FW.regular,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList()),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 12, horizontal: 16),
                                              child: Poppins(
                                                overflow: false,
                                                text: '${month} ${date}',
                                                size: 12,
                                                color: C.dark3,
                                                fontWeight: FW.bold,
                                              ),
                                            ),
                                            _postDetail!.numComment! > 0
                                                ? GestureDetector(
                                                    onTap: (() {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                            createTransitionRoute(
                                                                ViewComment(
                                                                    block_id: widget
                                                                        .block_id,
                                                                    imgAuthor:
                                                                        widget
                                                                            .imgAuthor,
                                                                    name: _postDetail!
                                                                        .name!),
                                                                1,
                                                                0),
                                                          )
                                                          .then((val) => val
                                                              ? _refresh()
                                                              : null);
                                                    }),
                                                    child: Column(
                                                      children: [
                                                        const Divider(
                                                          color:
                                                              C.boderAddPhotos,
                                                          thickness: 1,
                                                        ),
                                                        Container(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Poppins(
                                                              overflow: false,
                                                              text:
                                                                  'View all ${_postDetail!.numComment} comments',
                                                              size: 14,
                                                              color: C.dark3,
                                                              fontWeight:
                                                                  FW.bold,
                                                            )),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                filedata.length >
                                                                        3
                                                                    ? 3
                                                                    : filedata
                                                                        .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        left:
                                                                            16,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Poppins(
                                                                      text: filedata[
                                                                              index]
                                                                          [
                                                                          'name'],
                                                                      size: 12,
                                                                      color: C
                                                                          .dark3,
                                                                      fontWeight:
                                                                          FW.bold,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              12),
                                                                      child:
                                                                          Poppins(
                                                                        text: filedata[index]
                                                                            [
                                                                            'desc'],
                                                                        size:
                                                                            14,
                                                                        color: C
                                                                            .dark3,
                                                                        fontWeight:
                                                                            FW.regular,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  )
                                                : Container()
                                          ],
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 16),
                                    child: const Poppins(
                                      overflow: false,
                                      text: 'Related Post',
                                      size: 14,
                                      color: C.dark3,
                                      fontWeight: FW.bold,
                                    ),
                                  ),
                                  const Divider(
                                    color: C.boderAddPhotos,
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: isLoading == true
                                        ? Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: Image.asset(
                                                "assets/images/loading.gif",
                                                height: 45,
                                                width: 45,
                                              ),
                                            ),
                                          )
                                        : GridView.builder(
                                            shrinkWrap: true,
                                            primary: false,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                                    maxCrossAxisExtent: 200,
                                                    mainAxisExtent: 298,
                                                    crossAxisSpacing: 6,
                                                    mainAxisSpacing: 6),
                                            itemCount: data.length,
                                            itemBuilder:
                                                (BuildContext context, index) {
                                              return ShowPost(
                                                  topic: data[index]["title"],
                                                  name: data[index]["name"],
                                                  imgPath: data[index]["images"]
                                                      [0],
                                                  isLiked: data[index]
                                                      ["isLiked"],
                                                  block_id: data[index]["id"],
                                                  author_id: data[index]
                                                      [" author_id"],
                                                  tags: data[index]["tags"],
                                                  author_username: data[index]
                                                      ["username"],
                                                  imgAuthor: data[index]
                                                      ["imgAuthor"]);
                                            },
                                          ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Column(
                        children: [
                          SvgPicture.asset(
                            "assets/images/trash.svg",
                          ),
                          const SizedBox(height: 4),
                          const Poppins(
                              text: 'Post is deleted',
                              size: 14,
                              color: C.disableTextfield,
                              fontWeight: FW.regular),
                        ],
                      ),
                      Container(),
                    ],
                  )),
      ),
    );
  }

  _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      setState(() {
        data.clear();
      });
      var url =
          '${Url.baseurl}/blocks/related/${widget.block_id}?tags=${widget.tags}&user_id=${user_id}';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);

        (_data["data"] as List).map((e) => data.add(e)).toList();

        setState(() {
          isLoading = false;
        });
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      isLoading = false;
    }
  }

  Future<void> _getPostDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? user_id = prefs.getString('user_id');
      final String? username = prefs.getString('username');
      final String? token = prefs.getString('token');

      var url =
          '${Url.baseurl}/blocks/view/${widget.block_id}?user_id=${user_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.get(Uri.parse(url), headers: header);
      _postDetail = viewPostDetailFromJson(response.body);

      setState(() {
        usrname = username;
        isLoadingPost = false;
        numLiked = _postDetail!.liked!.length;
        isFavorited = _postDetail!.isLiked!;
        var splitDate = _postDetail!.date!.split("/");

        date = int.parse(splitDate[1]) < 10
            ? '0${int.parse(splitDate[1])}'
            : '${splitDate[1]}';
        month = int.parse(splitDate[0]) == 1
            ? 'Jan'
            : int.parse(splitDate[0]) == 2
                ? 'Feb'
                : int.parse(splitDate[0]) == 3
                    ? 'Mar'
                    : int.parse(splitDate[0]) == 4
                        ? 'Apr'
                        : int.parse(splitDate[0]) == 5
                            ? 'May'
                            : int.parse(splitDate[0]) == 6
                                ? 'Jun'
                                : int.parse(splitDate[0]) == 7
                                    ? 'Jul'
                                    : int.parse(splitDate[0]) == 8
                                        ? 'Aug'
                                        : int.parse(splitDate[0]) == 9
                                            ? 'Sep'
                                            : int.parse(splitDate[0]) == 10
                                                ? 'Oct'
                                                : int.parse(splitDate[0]) == 11
                                                    ? 'Nov'
                                                    : 'Dec';
      });
    } catch (e) {
      print(e);
      isLoadingPost = false;
    }
  }

  _deletePost(String block_id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      var url = '${Url.baseurl}/blocks/${block_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.delete(
        Uri.parse(url),
        headers: header,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);
      } else {
        print('err ==> ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  _likesPost() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/liked/?block_id=${widget.block_id}&user_id=${user_id}';

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

  _unlikesPost() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      final String? token = prefs.getString('token');
      var url =
          '${Url.baseurl}/profile/unliked/?block_id=${widget.block_id}&user_id=${user_id}';

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

  Future<void> _getComments() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString('username');

      final String? token = prefs.getString('token');

      var url = '${Url.baseurl}/comment/viewcomment/${widget.block_id}';

      Map<String, String> header = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      };

      var response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);
        setState(() {
          filedata.clear();
        });

        (_data["data"] as List).map((e) => filedata.add(e)).toList();

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
