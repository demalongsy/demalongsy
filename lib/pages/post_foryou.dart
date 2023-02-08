import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';

class PageForYou extends StatefulWidget {
  const PageForYou({super.key});

  @override
  State<PageForYou> createState() => _PageForYouState();
}

class _PageForYouState extends State<PageForYou> {
  List dataTest = [
    {"user": "Nicha"},
    {"user": "Nicha"},
    {"user": "Nicha"},
    {"user": "Nicha"},
  ];

  final _offsetToArmed = 220.0;

  Future<void> _onRefresh() async {
    // refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              color: C.dangerDefault,
              width: 30,
              height: 30,
            ),
            
            Container(
              color: C.dangerDefault,
              width: 30,
              height: 30,
            ),
            Container(
              color: C.dangerDefault,
              width: 30,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
