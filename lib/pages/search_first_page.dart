import 'dart:math';
import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/account_data.dart';
import 'package:demalongsy/pages/navbar.dart';
import 'package:demalongsy/pages/search.dart';
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

class SearchFirstPage extends StatefulWidget {
  final bool? isRootPage;
  const SearchFirstPage({Key? key, this.isRootPage}) : super(key: key);

  @override
  State<SearchFirstPage> createState() => _SearchState();
}

class _SearchState extends State<SearchFirstPage>
    with TickerProviderStateMixin {
  TextEditingController _searchController = new TextEditingController();
  String _searchInput = '';
  bool x = false;

  List<Account_data> accounts = Account_list;
  late TabController controller;
  bool checkAllSpaces(String input) {
    String output = input.replaceAll(' ', '');
    return output.isNotEmpty ? true : false;
  }

  void search(String input) {
    if (checkAllSpaces(input)) {
      Navigator.of(context, rootNavigator: false)
          .push(createTransitionRoute(Search(), 1, 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          widget.isRootPage ?? false ? NavigationService.searchKey : null,
      home: Scaffold(
        backgroundColor: C.white,
        appBar: AppBar(
          toolbarHeight: 52,
          automaticallyImplyLeading: false,
          backgroundColor: C.white,
          elevation: 0.0,
          title: Column(
            children: [
              widget.isRootPage ?? false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextField(
                              onSubmitted: search,
                              onChanged: (value) => setState(
                                () {
                                  _searchInput = value;
                                  // x = true;
                                },
                              ),
                              controller: _searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: C.disableField,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: C.disableField),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: C.infoDefault),
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
                    )
                  : Row(
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
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: TextField(
                              onSubmitted: search,
                              onChanged: (value) => setState(
                                () {
                                  _searchInput = value;
                                  x = true;
                                },
                              ),
                              controller: _searchController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: C.disableField,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: C.disableField),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 1, color: C.infoDefault),
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
                    )
            ],
          ),
        ),
      ),
    );
  }
}
