import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class FavoritePosts extends StatefulWidget {
  const FavoritePosts({super.key});

  @override
  State<FavoritePosts> createState() => _FavoritePostsState();
}

class _FavoritePostsState extends State<FavoritePosts> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Center(
          child: Spectral(
            text: "Favorite Post",
            color: C.primaryDefault,
            fontWeight: FontWeight.bold,
            size: 40,
          ),
        ),
      ),
    );
  }
}
