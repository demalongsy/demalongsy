import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//font widget for Poppins
class Poppins extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double? letterspacing;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? underline;

  const Poppins(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      this.fontStyle = FontStyle.normal,
      this.underline = false,
      this.letterspacing,
      this.textAlign,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: ScaleSize.textScaleFactor(context),
      style: GoogleFonts.poppins(
        decoration: underline ?? false ? TextDecoration.underline : null,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterspacing,
      ),
    );
  }
}

//font widget for Spectral
class Spectral extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double? letterspacing;
  final TextAlign? textAlign;
  final int? maxLines;

  const Spectral(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      this.fontStyle = FontStyle.normal,
      this.letterspacing,
      this.textAlign,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: ScaleSize.textScaleFactor(context),
      style: GoogleFonts.spectral(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterspacing),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 1.5}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
