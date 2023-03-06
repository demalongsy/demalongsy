import 'dart:math';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/pages/post/view_post.dart';
import 'package:flutter/material.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Center(
          child: Text(
            "No post",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context, rootNavigator: false)
            .push(createTransitionRoute(ViewPost(), 1, 0));
      },
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
