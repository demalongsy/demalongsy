import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: C.backgroundWhiteIvory,
        appBar: AppBar(
          backgroundColor: C.backgroundWhiteIvory,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: C.dark2,
                    size: 20.0,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Poppins(
              text: "Feedback Page",
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
