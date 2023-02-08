import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:flutter/material.dart';
import '../custom/toolkit.dart';
import 'package:flutter/material.dart';

class Tags extends StatefulWidget {
  const Tags({super.key});

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  int tag = 1;

  List<String> tags = [];

  List<String> options = [
    'Vintage 90s',
    'All black',
    'American',
    'Minimal',
    'Fairy',
    'Korean',
    'Y2K',
    'Boyish',
    'Business'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        backgroundColor: C.white,
        appBar: AppBar(
          backgroundColor: C.white,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(children: [
          Expanded(
            child: Container(
              child: SizedBox.expand(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Spectral(
                        text: "Choose",
                        color: C.dark1,
                        fontWeight: FW.bold,
                        size: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Spectral(
                        text: "your favorite style",
                        color: C.dark1,
                        fontWeight: FW.bold,
                        size: 36,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Spectral(
                        text: "Fantastic to start to use application!",
                        color: C.dark1,
                        fontWeight: FW.light,
                        size: 14,
                      ),
                    ),
                    Column(
                        //padding วางตรงนี้เป็นต้นไป
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ChipsChoice<String>.multiple(
                            value: tags,
                            onChanged: (val) => setState(() => tags = val),
                            choiceItems: C2Choice.listFrom(
                                source: options,
                                value: (i, v) => v,
                                label: (i, v) => v),
                            choiceActiveStyle: const C2ChoiceStyle(
                              labelStyle: TextStyle(color: C.primaryDefault),
                              backgroundColor: C.dark1,
                              color: C.primaryDefault,
                              borderColor: Color(0xFF0B6E40),
                              avatarBorderColor: C.primaryDefault,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              avatarBorderShape: OutlineInputBorder(),
                            ),
                            choiceStyle: const C2ChoiceStyle(
                              color: C.dark1,
                              borderColor: C.dark1,
                              avatarBorderColor: C.primaryDefault,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            wrapped: true,
                            textDirection: TextDirection.ltr,
                          )
                        ]),
                    SizedBox(
                      height: 284,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Navbar()));
                          // Navigator.of(context).push(
                          // MaterialPageRoute(builder: (context) => HomePage()));
                          //------------------------
                          // Navigator.of(context).push(
                          //   CupertinoPageRoute<bool>(
                          //     fullscreenDialog: true,
                          //     builder: (BuildContext context) => HomePage(),
                          //   ),
                          // );
                        },
                        child: const Button(
                          text: "Get Start",
                          fontWeight: FW.bold,
                          color: C.dark2,
                          size: 16,
                          boxColor: C.secondaryDefault,
                          boxHeight: 48,
                          haveBorder: false,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
