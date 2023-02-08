import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class PostTrending extends StatefulWidget {
  const PostTrending({super.key});

  @override
  State<PostTrending> createState() => _PostTrendingState();
}

class _PostTrendingState extends State<PostTrending> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Poppins(
          text: "Trending",
          color: C.primaryDefault,
          fontWeight: FW.regular,
          size: 40,
        ),
      ),
    );
  }
}
