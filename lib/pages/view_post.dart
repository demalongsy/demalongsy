import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/view_comment.dart';
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
    {"id": 1, "image_path": 'assets/images/Photo4.jpg'},
    {"id": 2, "image_path": 'assets/images/Photo2.jpg'},
    {"id": 3, "image_path": 'assets/images/Photo3.jpg'}
  ];
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  bool isFavorited = false;

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
        body: Column(
          children: [
            GestureDetector(
              // onDoubleTap: handleLikePost,
              child: Stack(
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
                              (item) => Image.asset(
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
                      children: imageList.asMap().entries.map((entry) {
                        print(entry);
                        print(entry.key);
                        return GestureDetector(
                          onTap: () =>
                              _carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentIndex == entry.key ? 7 : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentIndex == entry.key
                                  ? Colors.red
                                  : Colors.teal,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  child: Container(
                    // height: 36,
                    child: Row(
                      children: [
                        isFavorited
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isFavorited = false;
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
                                    Icons.favorite,
                                    color: C.dark1,
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
                                  ),
                                ),
                              ),
                        const Text('1'),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavorited = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 12),
                                decoration: BoxDecoration(
                                  color: C.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: SvgPicture.asset(
                                  'assets/images/Message_filled.svg',
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
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorited = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 12),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: const [
                        Text(
                          'มาแต่งตัวจากไอเดียคู่สีกันเถอะ',
                          style: TextStyle(
                            fontWeight: FW.bold,
                            color: C.dark2,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: const Text(
                        'เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์มันได้กลายมาเป็นเนื้อหาจำลองมาตรฐานของธุรกิจดังกล่าวมาตั้งแต่ศตวรรษที่ 16',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   handleLikePost() {
//     bool _isLiked = likes[currentUserId] == true;
//     if (_isLiked) {
//       setState(() {
//         likeCount -= 1;
//         _isLiked = false;
//         likes[currentUserId] = false;
//       });
//     }
//   }
}
