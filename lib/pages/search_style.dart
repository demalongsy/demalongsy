import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';

class SearchStyle extends StatefulWidget {
  final bool? rootPage;
  const SearchStyle({Key? key, this.rootPage}) : super(key: key);

  @override
  State<SearchStyle> createState() => _SearchStyleState();
}

class _SearchStyleState extends State<SearchStyle> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          widget.rootPage ?? false ? NavigationService.searchStyleKey : null,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Poppins(
              text: "Similar Style",
              color: C.primaryDefault,
              fontWeight: FontWeight.normal,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
