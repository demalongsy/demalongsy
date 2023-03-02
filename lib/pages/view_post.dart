import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/data_mockup_for_post.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/view_comment.dart';
import 'package:demalongsy/widget/showposts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
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
    }
  ];
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  bool isFavorited = false;
  List<Post> postDesc = allPost;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                    onTap: () => Navigator.of(context).pop(Profile()),
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
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Poppins(
                    text: "K.Payongdech",
                    size: 14,
                    color: C.dark1,
                    fontWeight: FW.bold,
                    letterspacing: 0.64,
                  ),
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 8),
                //   child: Icon(
                //     Icons.more_horiz,
                //     color: C.dark2,
                //     size: 24.0,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
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
                                fit: BoxFit.cover,
                                width: double.infinity,
                                // height: 500,
                              ),
                            )
                            .toList(),
                        carouselController: _carouselController,
                        options: CarouselOptions(
                          height: 460,
                          scrollPhysics: const BouncingScrollPhysics(),
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
                            onTap: () =>
                                _carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 7 : 7,
                              height: 7.0,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == entry.key
                                    ? Colors.red
                                    : Colors.teal,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
                                    borderRadius: BorderRadius.circular(50),
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
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(
                                    Icons.favorite_outline_rounded,
                                    color: C.dark1,
                                    size: 24,
                                  ),
                                ),
                              ),
                        const Text('1'),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  createTransitionRoute(ViewComment(), 1, 0),
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
                            const Text('1'),
                          ],
                        )
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
                              mainAxisSize: MainAxisSize.min,
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
                                const Divider(color: C.addBorderPhoto),
                                // ListTile(
                                //   leading: Container(
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(8),
                                //     ),
                                //     width: 72,
                                //     height: 72,
                                //     child: SvgPicture.network(
                                //         'https://hips.hearstapps.com/hmg-prod/images/fashion-model-naomi-campbell-wears-a-furry-cocktail-dress-news-photo-1656444150.jpg'),
                                //   ),
                                // ),

                                // No ListTile
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            child: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    const Poppins(
                                                        overflow: false,
                                                        text: 'Photo 1',
                                                        size: 16,
                                                        color: C.dark2,
                                                        fontWeight: FW.bold),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Expanded(
                                                        child: Container()),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color:
                                                            C.secondaryDefault,
                                                      ),
                                                      width: 70,
                                                      height: 24,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 2),
                                                      child: const Center(
                                                        child: Poppins(
                                                            overflow: false,
                                                            text: 'Pick',
                                                            size: 16,
                                                            color: C.dark2,
                                                            fontWeight:
                                                                FW.bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 5.0),
                                                  child: const Poppins(
                                                      overflow: false,
                                                      text:
                                                          'Pick to suggest item',
                                                      size: 12,
                                                      color: C.dark1,
                                                      fontWeight: FW.regular),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.only(top: 5.0),
                    child: const Poppins(
                      overflow: false,
                      text:
                          'เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16',
                      size: 14,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      // letterspacing: 0,
                      // maxLines: 2,
                      // fontRespon: false,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
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
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
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
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Poppins(
                      overflow: false,
                      text: 'Oct 02',
                      size: 12,
                      color: C.dark3,
                      fontWeight: FW.bold,
                    ),
                  ),
                  const Divider(color: C.addBorderPhoto),
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
                  const Divider(color: C.addBorderPhoto),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GridView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 298,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6),
                      itemCount: postDesc.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: ShowPost(
                              topic: postDesc[index].topic,
                              name: postDesc[index].name,
                              imgAcc: postDesc[index].imgAcc,
                              imgPath: postDesc[index].imgPath),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
