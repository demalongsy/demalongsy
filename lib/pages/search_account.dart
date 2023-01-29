import 'dart:math';
import 'package:flutter/material.dart';

class SearchAccount extends StatefulWidget {
  const SearchAccount({super.key});

  @override
  State<SearchAccount> createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://i.pinimg.com/736x/7c/06/3e/7c063e231282b24ac6201b1891cf0931.jpg")),
      title: Text('Peep Peep'),
    ));
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
