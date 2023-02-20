import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/custom/widget/page_transition.dart';
import 'package:demalongsy/models/data_mockup_for_post.dart';

import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/signup.dart';

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
  bool isFavorited = false;
  List<Post> postDesc = allPost;


  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  void initState() {
    super.initState();
    _calculation;
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
              color: C.backgroundWhiteIvory,
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: FutureBuilder<String>(
                        future: _calculation,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          List<Widget> children;
                          if (snapshot.hasData) {
                            children = <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Search(
                                        isBack: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                  size: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Result: ${snapshot.data}'),
                              ),
                            ];
                          } else if (snapshot.hasError) {
                            children = <Widget>[
                              const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Text('Error: ${snapshot.error}'),
                              ),
                            ];
                          } else {
                            children = const <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                                child: Text('Awaiting result...'),
                              ),
                            ];
                          }
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: children,
                            ),
                          );
                        },
                      ),
                    ),
                  )),
                  SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Wrap(
                        runSpacing: 6,
                        spacing: 6,
                        children: postDesc
                            .map((post) => AllPost(post.topic, post.name,
                                post.imgAcc, post.imgPath))
                            .toList(),
                      ),
                    ),
                  )),
                ],
              ),
            )),
      ),
    );
  }

  Widget AllPost(String topic, String name, String imgAcc, String imgPath) {
    return GestureDetector(
      onTap: (() {
        print(imgPath);
      }),
      child: Container(
        width: 168,
        height: 289,
        decoration: BoxDecoration(
            color: C.white, borderRadius: BorderRadius.circular(8)),
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: 198,
                width: 168,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8)),
                  image: DecorationImage(
                      image: NetworkImage(imgPath), fit: BoxFit.fill),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Poppins(
                  text: topic,
                  size: 14,
                  color: C.dark1,
                  fontWeight: FW.bold,
                  letterspacing: 0.64,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Color(0xff74EDED),
                      backgroundImage: NetworkImage(imgAcc),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Poppins(
                      text: name,
                      size: 10,
                      color: C.dark1,
                      fontWeight: FW.regular,
                      letterspacing: 0.64,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 168,
              height: 40,
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Expanded(child: Container()),
                  isFavorited
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorited = false;
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: C.dark1,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorited = true;
                            });
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: C.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              color: C.dark1,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}

