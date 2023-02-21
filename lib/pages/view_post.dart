import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/view_comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewPost extends StatefulWidget {
  const ViewPost({super.key});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
            child: Scaffold(
      backgroundColor: C.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: C.white,
          elevation: 0,
          title: Row(children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(Navbar()),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: C.dark2,
                size: 16.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(Profile()),
                child: Container(
                  // color: C.dangerDefault,
                  width: 40,
                  height: 40,
                  child: const CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg'),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Poppins(
                text: "K.Payongdech",
                size: 14,
                color: C.dark1,
                fontWeight: FW.bold,
                letterspacing: 0.64,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(Navbar()),
                child: const Icon(
                  Icons.more_horiz,
                  color: C.dark2,
                  size: 24.0,
                ),
              ),
            ),
          ]),
        ),
      ),
      body: GestureDetector(
          onTap: () => Navigator.of(context).pop(ViewComment()),
          child: Container(
            child: Center(
              child: Text(
                "Comment",
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
                textScaleFactor: ScaleSize.textScaleFactor(context),
              ),
            ),
          )),
    )));
  }
}
