import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../custom/widget/component.dart';

class ViewComment extends StatefulWidget {
  const ViewComment({super.key});

  @override
  State<ViewComment> createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
          body: Container(
        child: Center(
          child: Text(
            "Comment",
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
        ),
      )),
    ));
  }
}
