import 'package:demalongsy/custom/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Longin extends StatefulWidget {
  const Longin({super.key});

  @override
  State<Longin> createState() => _LonginState();
}

class _LonginState extends State<Longin> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'Demalongsy',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spectral(fontSize: 40, color: C.primaryDefault),
          ),
        ),
      ),
    );
  }
}
