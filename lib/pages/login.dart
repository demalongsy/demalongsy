import 'package:demalongsy/custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Longin extends StatefulWidget {
  const Longin({super.key});

  @override
  State<Longin> createState() => _LonginState();
}

class _LonginState extends State<Longin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SvgPicture.asset(
          'assets/images/bg.svg',
          alignment: Alignment.center,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
