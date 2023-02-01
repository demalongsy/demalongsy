import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class PageForYou extends StatefulWidget {
  const PageForYou({super.key});

  @override
  State<PageForYou> createState() => _PageForYouState();
}

class _PageForYouState extends State<PageForYou> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Poppins(
          text: "For You",
          color: C.primaryDefault,
          fontWeight: FW.regular,
          size: 40,
        ),
      ),
    );
  }
}
