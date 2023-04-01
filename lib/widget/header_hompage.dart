import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/pages/post/create_post.dart';
import 'package:demalongsy/pages/post/post_foryou.dart';
import 'package:demalongsy/pages/post/post_trending.dart';
import 'package:demalongsy/pages/search/search_first_page.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/pages/search/search.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';

class HeaderHomePage extends StatefulWidget {
  const HeaderHomePage({super.key});

  @override
  State<HeaderHomePage> createState() => _HeaderHomePageState();
}

class _HeaderHomePageState extends State<HeaderHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  bool isTapped = true;

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
      navigatorKey: NavigationService.headerKey,
      home: SafeArea(
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .push(createTransitionRoute(CreatePost(), 1, 0));
              },
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
                      tabs: const [
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
                          builder: (context) => SearchFirstPage(
                              // isBack: true,
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
            body: TabBarView(
              controller: tabController,
              children: [PostForYou(), PostTrending()],
            )),
      ),
    );
  }
}
