import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demalongsy/base_URL/url.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/another/another_profile.dart';
import 'package:demalongsy/pages/auth/login.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/profile/profile.dart';
import 'package:demalongsy/pages/comments/view_comment.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class ViewPost extends StatefulWidget {
  final List<dynamic> tags;
  final String block_id;
  const ViewPost({Key? key, required this.tags, required this.block_id})
      : super(key: key);

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  List imageList = [
    {
      "id": 1,
      "image_path":
          'https://hips.hearstapps.com/hmg-prod/images/fashion-model-naomi-campbell-wears-a-furry-cocktail-dress-news-photo-1656444150.jpg'
    },
    {
      "id": 2,
      "image_path":
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'
    },
    {
      "id": 3,
      "image_path":
          'https://static01.nyt.com/images/2022/12/22/fashion/21FASHION-AND-SPORTS-6-a8ea/21FASHION-AND-SPORTS-6-a8ea-mobileMasterAt3x.jpg'
    },
    {
      "id": 4,
      "image_path":
          'https://hips.hearstapps.com/hmg-prod/images/fashion-model-naomi-campbell-wears-a-furry-cocktail-dress-news-photo-1656444150.jpg'
    },
    {
      "id": 5,
      "image_path":
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'
    },
    {
      "id": 6,
      "image_path":
          'https://static01.nyt.com/images/2022/12/22/fashion/21FASHION-AND-SPORTS-6-a8ea/21FASHION-AND-SPORTS-6-a8ea-mobileMasterAt3x.jpg'
    },
    {
      "id": 7,
      "image_path":
          'https://hips.hearstapps.com/hmg-prod/images/fashion-model-naomi-campbell-wears-a-furry-cocktail-dress-news-photo-1656444150.jpg'
    },
    {
      "id": 8,
      "image_path":
          'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'
    },
    {
      "id": 9,
      "image_path":
          'https://static01.nyt.com/images/2022/12/22/fashion/21FASHION-AND-SPORTS-6-a8ea/21FASHION-AND-SPORTS-6-a8ea-mobileMasterAt3x.jpg'
    },
    {
      "id": 10,
      "image_path":
          'https://hips.hearstapps.com/hmg-prod/images/fashion-model-naomi-campbell-wears-a-furry-cocktail-dress-news-photo-1656444150.jpg'
    },
  ];
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  bool isDeleted = false;
  bool isFavorited = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
                    onTap: () => Navigator.of(context).pop(),
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
                                const AnotherProfile(), 1, 0));
                      },
                      child: Container(
                        // color: C.dangerDefault,
                        width: 40,
                        height: 40,
                        child: const CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
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
                                    const AnotherProfile(), 1, 0));
                          },
                          child: const Poppins(
                            text: "K.Payongdech",
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
                  GestureDetector(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: GestureDetector(
                                  child: const Button(
                                    text: 'Delete Post',
                                    size: 16,
                                    hasImg: true,
                                    pathImg: "assets/images/trash-dark.svg",
                                    color: C.dark1,
                                    fontWeight: FW.regular,
                                    customRadius: true,
                                    radius: 8,
                                    boxColor: C.boderAddPhotos,
                                    boxHeight: 56,
                                  ),
                                  onTap: () async {
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
                                                text: "delete post?",
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
                                              onPressed: () {
                                                setState(() {
                                                  isDeleted = true;
                                                });
                                                Navigator.of(context).pop();
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
                  ),
                ],
              ),
            ),
          ),
          body: isDeleted == false
              ? RefreshIndicator(
                  color: C.primaryDefault,
                  backgroundColor: C.white,
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    return Future<void>.delayed(const Duration(seconds: 2));
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                print(currentIndex);
                              },
                              child: Container(
                                // height: 460,
                                child: CarouselSlider(
                                  items: imageList
                                      .map(
                                        (item) => Image.network(
                                          item['image_path'],
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          // height: 500,
                                        ),
                                      )
                                      .toList(),
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    height: 460,
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    autoPlay: false,
                                    aspectRatio: 2,
                                    viewportFraction: 1,
                                    onPageChanged: ((index, reason) {
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: imageList.asMap().entries.map(
                                  (entry) {
                                    print(entry);
                                    print(entry.key);
                                    return GestureDetector(
                                      onTap: () => _carouselController
                                          .animateToPage(entry.key),
                                      child: Container(
                                        width:
                                            currentIndex == entry.key ? 7 : 7,
                                        height: 7.0,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: currentIndex == entry.key
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
                                  borderRadius: BorderRadius.circular(14),
                                  color: C.dark3,
                                ),
                                child: Center(
                                  child: Poppins(
                                      text:
                                          '${currentIndex + 1}/${imageList.length}',
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              // height: 36,
                              child: Row(
                                children: [
                                  isFavorited
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(
                                              () {
                                                isFavorited = false;
                                              },
                                            );
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            decoration: BoxDecoration(
                                              color: C.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Icon(
                                              Icons.favorite,
                                              color: C.dark1,
                                              size: 24,
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isFavorited = true;
                                            });
                                          },
                                          child: Container(
                                            height: 32,
                                            width: 32,
                                            decoration: BoxDecoration(
                                              color: C.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Icon(
                                              Icons.favorite_outline_rounded,
                                              color: C.dark1,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                  const Poppins(
                                    text: "1",
                                    size: 14,
                                    maxLines: 1,
                                    overflow: true,
                                    color: C.dark1,
                                    fontWeight: FW.bold,
                                    letterspacing: 0.64,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        createTransitionRoute(
                                            ViewComment(), 1, 0),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 12),
                                      decoration: BoxDecoration(
                                        color: C.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/message_filled.svg',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                  const Poppins(
                                    text: "1",
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
                              padding: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    context: context,
                                    useRootNavigator: true,
                                    builder: (BuildContext context) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 24),
                                          SvgPicture.asset(
                                            "assets/images/line.svg",
                                            width: 8,
                                            height: 4,
                                            color: C.dark2,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Poppins(
                                                text: "Pick to Suggest Items",
                                                size: 18,
                                                color: C.dark1,
                                                fontWeight: FW.bold),
                                          ),
                                          const Divider(
                                              color: C.boderAddPhotos),
                                          Expanded(
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child:
                                                                const CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: [
                                                                    const Poppins(
                                                                        overflow:
                                                                            false,
                                                                        text:
                                                                            'Photo 1',
                                                                        size:
                                                                            16,
                                                                        color: C
                                                                            .dark2,
                                                                        fontWeight:
                                                                            FW.bold),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: C
                                                                            .secondaryDefault,
                                                                      ),
                                                                      width: 70,
                                                                      height:
                                                                          24,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          const Center(
                                                                        child: Poppins(
                                                                            overflow:
                                                                                false,
                                                                            text:
                                                                                'Pick',
                                                                            size:
                                                                                14,
                                                                            color:
                                                                                C.dark2,
                                                                            fontWeight: FW.bold),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: const Poppins(
                                                                      overflow:
                                                                          false,
                                                                      text:
                                                                          'Pick to suggest item',
                                                                      size: 12,
                                                                      color: C
                                                                          .dark1,
                                                                      fontWeight:
                                                                          FW.regular),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child:
                                                                const CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: [
                                                                    const Poppins(
                                                                        overflow:
                                                                            false,
                                                                        text:
                                                                            'Photo 1',
                                                                        size:
                                                                            16,
                                                                        color: C
                                                                            .dark2,
                                                                        fontWeight:
                                                                            FW.bold),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: C
                                                                            .secondaryDefault,
                                                                      ),
                                                                      width: 70,
                                                                      height:
                                                                          24,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          const Center(
                                                                        child: Poppins(
                                                                            overflow:
                                                                                false,
                                                                            text:
                                                                                'Pick',
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                C.dark2,
                                                                            fontWeight: FW.bold),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: const Poppins(
                                                                      overflow:
                                                                          false,
                                                                      text:
                                                                          'Pick to suggest item',
                                                                      size: 12,
                                                                      color: C
                                                                          .dark1,
                                                                      fontWeight:
                                                                          FW.regular),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15,
                                                            right: 15),
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child:
                                                                const CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Row(
                                                                  children: [
                                                                    const Poppins(
                                                                        overflow:
                                                                            false,
                                                                        text:
                                                                            'Photo 1',
                                                                        size:
                                                                            16,
                                                                        color: C
                                                                            .dark2,
                                                                        fontWeight:
                                                                            FW.bold),
                                                                    const SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container()),
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: C
                                                                            .secondaryDefault,
                                                                      ),
                                                                      width: 70,
                                                                      height:
                                                                          24,
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              2),
                                                                      child:
                                                                          const Center(
                                                                        child: Poppins(
                                                                            overflow:
                                                                                false,
                                                                            text:
                                                                                'Pick',
                                                                            size:
                                                                                16,
                                                                            color:
                                                                                C.dark2,
                                                                            fontWeight: FW.bold),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      top: 5.0),
                                                                  child: const Poppins(
                                                                      overflow:
                                                                          false,
                                                                      text:
                                                                          'Pick to suggest item',
                                                                      size: 12,
                                                                      color: C
                                                                          .dark1,
                                                                      fontWeight:
                                                                          FW.regular),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 12),
                                  decoration: BoxDecoration(
                                    color: C.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/laundry.svg',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: const Poppins(
                                      overflow: false,
                                      text: 'มาแต่งตัวจากไอเดียคู่สีกันเถอะ',
                                      size: 18,
                                      color: C.dark2,
                                      fontWeight: FW.bold),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              margin: const EdgeInsets.only(top: 5.0),
                              child: const Poppins(
                                overflow: false,
                                text:
                                    'เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16',
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
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: C.secondaryDefault,
                                      ),
                                      height: 24,
                                      child: const Poppins(
                                        overflow: false,
                                        text: '#MinimalStyle',
                                        size: 14,
                                        color: C.dark3,
                                        fontWeight: FW.regular,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: C.secondaryDefault,
                                      ),
                                      height: 24,
                                      child: const Poppins(
                                        overflow: false,
                                        text: '#Korea',
                                        size: 14,
                                        color: C.dark3,
                                        fontWeight: FW.regular,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16),
                              child: Poppins(
                                overflow: false,
                                text: 'Oct 02',
                                size: 12,
                                color: C.dark3,
                                fontWeight: FW.bold,
                              ),
                            ),
                            const Divider(color: C.boderAddPhotos),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  createTransitionRoute(ViewComment(), 1, 0),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: const Poppins(
                                  overflow: false,
                                  text: 'View all 3 comments',
                                  size: 14,
                                  color: C.dark3,
                                  fontWeight: FW.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 10),
                                  alignment: Alignment.centerLeft,
                                  child: const Poppins(
                                    text: 'K.Payongdech',
                                    size: 12,
                                    color: C.dark3,
                                    fontWeight: FW.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 12),
                                    alignment: Alignment.centerRight,
                                    child: const Poppins(
                                      text:
                                          'เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16',
                                      size: 16,
                                      color: C.dark3,
                                      fontWeight: FW.regular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 16, right: 10),
                                  alignment: Alignment.centerLeft,
                                  child: const Poppins(
                                    text: 'K.Payongdech',
                                    size: 12,
                                    color: C.dark3,
                                    fontWeight: FW.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 12),
                                    alignment: Alignment.centerRight,
                                    child: const Poppins(
                                      text:
                                          'เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16',
                                      size: 16,
                                      color: C.dark3,
                                      fontWeight: FW.regular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 36,
                            ),
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
                            const Divider(color: C.boderAddPhotos),
                            const SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 13),
                            //   child: isLoading == true
                            //       ? const Center(
                            //           child: CircularProgressIndicator(),
                            //         )
                            //       : GridView.builder(
                            //           shrinkWrap: true,
                            //           primary: false,
                            //           physics: NeverScrollableScrollPhysics(),
                            //           gridDelegate:
                            //               const SliverGridDelegateWithMaxCrossAxisExtent(
                            //                   maxCrossAxisExtent: 200,
                            //                   mainAxisExtent: 298,
                            //                   crossAxisSpacing: 6,
                            //                   mainAxisSpacing: 6),
                            //           itemCount: data.length,
                            //           itemBuilder:
                            //               (BuildContext context, index) {
                            //             return ShowPost(
                            //                 topic: data[index]["title"],
                            //                 name: data[index]["username"],
                            //                 imgAcc: data[index]["imgAuthor"],
                            //                 imgPath: data[index]["images"][0],
                            //                 isLiked: data[index]["isLiked"],
                            //                 block_id: data[index]["id"],
                            //                 author_id: data[index]
                            //                     [" author_id"],
                            //                 tags: data[index]["tags"]);
                            //           },
                            //         ),
                            // ),
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
                ),
        ),
      ),
    );
  }

  _getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? user_id = prefs.getString('user_id');
      var url =
          '${Url.baseurl}/blocks/related?tags=${widget.tags}&user_id=${user_id}';

      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var _data = convert.jsonDecode(response.body);
        data = [];
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
}
