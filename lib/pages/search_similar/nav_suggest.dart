import 'dart:io';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/search_similar/search_style.dart';
import 'package:demalongsy/pages/search_similar/similar_style.dart';
import 'package:demalongsy/pages/search_similar/suggest_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../custom/toolkit.dart';
import '../../custom/widget/page_transition.dart';

class Nav_Suggest extends StatefulWidget {
  final File? image;
  final bool isformPost;
  const Nav_Suggest({Key? key, this.image, required this.isformPost})
      : super(key: key);

  @override
  State<Nav_Suggest> createState() => _Nav_SuggestState();
}

class _Nav_SuggestState extends State<Nav_Suggest> {
  List pages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        SimilarStylePage(image: widget.image, isformPost: false),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 104,
            decoration: BoxDecoration(
              color: C.nav,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: GestureDetector(
              onTap: (() {
                Navigator.of(context, rootNavigator: true)
                    .push(createTransitionRoute(SuggestStylePage(), 1, 0));
              }),
              child: Center(
                child: Wrap(
                  children: [
                    const Poppins(
                      text: "Find out more Suggest Items ",
                      size: 16,
                      color: C.nav_tag,
                      fontWeight: FW.bold,
                      letterspacing: 0.64,
                      underline: true,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SvgPicture.asset(
                        "assets/images/arrow.svg",
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
