import 'dart:math';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Widget button for GestureDetector!
class Button extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final double boxHeight;
  final Color boxColor;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double? letterspacing;
  final TextAlign? textAlign;
  final bool? haveBorder;
  final String? pathImg;
  final bool? hasImg;
  final bool? declareWidth;
  final double? width;
  final bool? customRadius;
  final double? radius;

  const Button(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      required this.boxColor,
      required this.boxHeight,
      this.fontStyle = FontStyle.normal,
      this.letterspacing,
      this.haveBorder,
      this.textAlign,
      this.pathImg,
      this.hasImg = false,
      this.declareWidth = false,
      this.width,
      this.customRadius = false,
      this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: customRadius ?? false
            ? BorderRadius.circular(radius ?? 0)
            : BorderRadius.circular(50),
        border:
            haveBorder == true ? Border.all(width: 1, color: C.dark2) : null,
      ),
      height: boxHeight,
      width: declareWidth == true ? width : null,
      child: hasImg ?? false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  pathImg.toString(),
                  width: 23,
                  height: 23,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  text,
                  textAlign: textAlign,
                  style: GoogleFonts.poppins(
                    fontSize: size,
                    color: color,
                    fontWeight: fontWeight,
                    letterSpacing: letterspacing,
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                text,
                textAlign: textAlign,
                style: GoogleFonts.poppins(
                  fontSize: size,
                  color: color,
                  fontWeight: fontWeight,
                  letterSpacing: letterspacing,
                ),
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
