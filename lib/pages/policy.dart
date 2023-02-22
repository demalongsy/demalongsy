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
        body: SingleChildScrollView(
          child: Center(
            child: Poppins(
              text: "Policy Page",
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
