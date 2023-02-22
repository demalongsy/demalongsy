import 'package:demalongsy/custom/key/navigate.dart';
import 'package:demalongsy/pages/search_first_page.dart';
import 'package:demalongsy/pages/search_style.dart';

import '../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demalongsy/pages/profile.dart';

import 'package:demalongsy/widget/header_hompage.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;

  final GlobalKey<NavigatorState> firstTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> secondTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> thirdTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> forthTabNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                navigatorKey: firstTabNavKey,
                builder: (BuildContext context) => const HeaderHomePage(),
              );

            case 1:
              return CupertinoTabView(
                navigatorKey: secondTabNavKey,
                builder: (BuildContext context) => const SearchFirstPage(
                  isRootPage: true,
                ),
              );

            case 2:
              return CupertinoTabView(
                navigatorKey: thirdTabNavKey,
                builder: (BuildContext context) => const SearchStyle(
                  isRootPage: true,
                ),
              );

            case 3:
              return CupertinoTabView(
                navigatorKey: forthTabNavKey,
                builder: (BuildContext context) =>
                    const Profile(isRootPage: true, isOwner: true),
              );
          }
          return const HeaderHomePage();
        },
        tabBar: CupertinoTabBar(
          backgroundColor: C.white,
          height: 76,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/images/homeFo.svg",
                width: 23,
                height: 23,
              ),
              icon: SvgPicture.asset(
                "assets/images/homeDe.svg",
                width: 23,
                height: 23,
                color: C.dark2.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/images/magnifying.svg",
                width: 23,
                height: 23,
              ),
              icon: SvgPicture.asset(
                "assets/images/magnifying.svg",
                width: 23,
                height: 23,
                color: C.dark2.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/images/laundryFo.svg",
                width: 23,
                height: 23,
              ),
              icon: SvgPicture.asset(
                "assets/images/laundryDe.svg",
                width: 23,
                height: 23,
                color: C.dark2.withOpacity(0.5),
              ),
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(
                "assets/images/user-solid.svg",
                width: 23,
                height: 23,
              ),
              icon: SvgPicture.asset(
                "assets/images/user-regular.svg",
                width: 23,
                height: 23,
                color: C.dark2.withOpacity(0.5),
              ),
            ),
          ],
          onTap: (index) {
            if (currentIndex == index) {
              switch (index) {
                case 0:
                  NavigationService.headerKey.currentState!
                      .popUntil((r) => r.isFirst);
                  firstTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 1:
                  NavigationService.searchKey.currentState!
                      .popUntil((r) => r.isFirst);
                  secondTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 2:
                  NavigationService.searchStyleKey.currentState!
                      .popUntil((r) => r.isFirst);
                  thirdTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 3:
                  NavigationService.profileKey.currentState!
                      .popUntil((r) => r.isFirst);
                  forthTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
              }
            }
            currentIndex = index;
          },
        ),
      ),
    );
  }
}
