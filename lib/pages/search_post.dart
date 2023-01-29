import 'dart:math';
import 'package:flutter/material.dart';

class SearchPost extends StatefulWidget {
  const SearchPost({super.key});

  @override
  State<SearchPost> createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "1st tab",
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.center,
          textScaleFactor: ScaleSize.textScaleFactor(context),
        ),
      ),
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
