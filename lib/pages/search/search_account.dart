import 'dart:math';
import 'package:demalongsy/pages/profile/profile.dart';
import 'package:demalongsy/pages/comments/view_comment.dart';

import '../../custom/toolkit.dart';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/models/account_data.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/pages/search/search.dart';

import '../../custom/widget/page_transition.dart';

class SearchAccount extends StatefulWidget {
  const SearchAccount({super.key});

  @override
  State<SearchAccount> createState() => _SearchAccountState();
}

class _SearchAccountState extends State<SearchAccount> {
  List<Account_data> accounts = Account_list;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: accounts.length,
              itemBuilder: ((context, index) {
                final account = accounts[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(account.urlImage),
                      ),
                    ),
                    title: Poppins(
                        text: account.title,
                        size: 14,
                        color: C.dark1,
                        fontWeight: FW.bold),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                        createTransitionRoute(Profile(), 1, 0),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
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
