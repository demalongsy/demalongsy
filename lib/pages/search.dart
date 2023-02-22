import 'dart:math';
import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/models/account_data.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:demalongsy/pages/search_post.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:demalongsy/pages/search_account.dart';
import 'package:demalongsy/custom/widget/component.dart';

class Search extends StatefulWidget {
  final bool? isBack;
  const Search({Key? key, this.isBack = false}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  TextEditingController _searchController = new TextEditingController();
  String _searchInput = '';
  bool x = false;

  List<Account_data> accounts = Account_list;
  late TabController controller;
  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.white,
      appBar: AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          backgroundColor: C.white,
          elevation: 0.0,
          title: Column(
            children: [
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: C.dark2,
                        size: 16.0,
                      ),
                      // IconButton(
                      //   icon: const Icon(Icons.arrow_back_ios_rounded,
                      //       size: 16.0, color: Colors.black),
                      //   onPressed: () => Navigator.of(context).pop(),
                      // ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      // width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextFormField(
                        onChanged: (value) => setState(() {
                          _searchInput = value;
                          x = true;
                        }),
                        controller: _searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: C.disableField,
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: C.disableField),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: C.infoDefault),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // contentPadding: EdgeInsets.symmetric(vertical: 36),
                            hintText: 'Search...',
                            hintStyle: const TextStyle(
                              color: C.disableTextfield,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 0),
                            prefixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: SvgPicture.asset(
                                'assets/images/search-icon-grey.svg',
                                alignment: Alignment.center,
                                fit: BoxFit.fill,
                                // width: MediaQuery.of(context).size.width,
                                // height: MediaQuery.of(context).size.height,
                              ),
                            ),
                            suffixIcon: _searchInput.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      setState(() {
                                        _searchInput = '';
                                      });
                                    },
                                    child: const Align(
                                      widthFactor: 0.5,
                                      heightFactor: 1.0,
                                      child: Icon(
                                        Icons.close,
                                      ),
                                    ),
                                  )
                                : null),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: C.dark1,
                          fontWeight: FW.regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TabBar(
                // controller: controller,
                labelColor: Colors.black,
                // labelPadding: const EdgeInsets.symmetric(horizontal: 2),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0),
                  insets: EdgeInsets.symmetric(horizontal: 110.0, vertical: 0),
                ),
                indicatorColor: C.dark1,
                labelStyle: TextStyle(fontWeight: FW.bold, fontSize: 14),
                controller: controller,
                tabs: const [
                  Tab(
                    // icon: Icon(Icons.home),
                    text: "Post",
                  ),
                  Tab(
                    text: "Account",
                  )
                ],
              ),
            ],
          )),
      body: TabBarView(controller: controller, children: [
        //post
        SearchPost(),
        //account
        SearchAccount()
      ]),
    );
  }

  void searchAccount(String query) {
    final suggesttions = Account_list.where((account) {
      final accountTitle = account.title.toLowerCase();
      final input = query.toLowerCase();
      return accountTitle.contains(input);
    }).toList();
    setState(() => accounts = suggesttions);
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
