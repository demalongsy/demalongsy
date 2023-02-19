import 'dart:math';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/models/account_data.dart';
import 'package:demalongsy/models/action_chips.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/widget/action_chip_data.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:demalongsy/custom/toolkit.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({super.key});

  @override
  State<HeaderHomePage> createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool isTapped = true;
  bool isSelectedFirstPages = true;
  List<Account_data> accounts = Account_list;
  int index = 0;
  final double spacing = 8;
  List favUserSelect = [];

  // List<ChipData> chips = Chips.all;
  List<FilterChipData> filterChips = FilterChips.all;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: C.primaryDefault,
              elevation: 3,
              child: const Icon(
                Icons.add_rounded,
                size: 48,
                color: C.textDefault,
              ),
            ),
            appBar: AppBar(
              backgroundColor: C.white,
              centerTitle: true,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Container()),
                  Container(
                    width: 200,
                    height: 36,
                    color: C.white,
                    child: TabBar(
                      labelColor: C.dark2,
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FW.bold),
                      isScrollable: false,
                      unselectedLabelColor: C.dark2,
                      unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FW.regular),
                      indicator: BoxDecoration(
                        color: C.secondaryDefault,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      controller: tabController,
                      tabs: [
                        Text(
                          "For you",
                        ),
                        Text(
                          "Trending",
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  Listener(
                    // ignore: sort_child_properties_last
                    child: Icon(
                      Icons.search_rounded,
                      color: isTapped == true ? C.disableTextfield : C.dark2,
                    ),
                    onPointerUp: (event) {
                      setState(() {
                        isTapped = true;
                      });
                    },
                    onPointerDown: ((event) {
                      setState(() {
                        isTapped = false;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Search(
                                isBack: true,
                              )));
                    }),
                    onPointerMove: (event) {
                      setState(() {
                        isTapped = true;
                      });
                    },
                  )
                ],
              ),
            ),
            body: Container(
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          children: filterChips
                              .map((filterChip) => Fuck(filterChip.label))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          children: filterChips
                              .map((filterChip) => Fuck(filterChip.label))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget Fuck(String a) {
    return ListTile(
      title: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Profile()));
        },
        child: Poppins(text: a, size: 14, color: C.dark1, fontWeight: FW.bold),
      ),
    );
  }
}
