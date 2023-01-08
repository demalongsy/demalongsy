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

  const Poppins(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      this.fontStyle = FontStyle.normal,
      this.letterspacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterspacing),
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

  const Spectral(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      this.fontStyle = FontStyle.normal,
      this.letterspacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.spectral(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterspacing),
    );
  }
}
