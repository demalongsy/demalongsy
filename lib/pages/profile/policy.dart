import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:flutter/material.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({super.key});

  @override
  State<PolicyPage> createState() => _PolicyPageState();
}

class _PolicyPageState extends State<PolicyPage> {
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
                    Icons.close_rounded,
                    color: C.dark2,
                    size: 30.0,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              Expanded(child: SizedBox()),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              //this
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    color: C.dangerDefault,
                  )),
                  Expanded(
                    //this
                    child: Container(
                      height: 300,
                      color: C.primaryDefault,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (int i = 0; i < 100; i++) Text('Text $i'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
