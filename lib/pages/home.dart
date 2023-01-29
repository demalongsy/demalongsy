import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: const [
              Poppins(
                text: "Home Page",
                color: C.primaryDefault,
                fontWeight: FontWeight.normal,
                size: 40,
              ),
              Text(
                'Home Page',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
