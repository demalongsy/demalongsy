import '../custom/toolkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demalongsy/pages/home.dart';
import 'package:demalongsy/pages/login.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/pages/choose_style.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/edit_profile.dart';

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
                builder: (BuildContext context) => HomePage(),
              );
              break;
            case 1:
              return CupertinoTabView(
                navigatorKey: secondTabNavKey,
                builder: (BuildContext context) => Search(),
              );
              break;
            case 2:
              return CupertinoTabView(
                navigatorKey: thirdTabNavKey,
                builder: (BuildContext context) => ChooseStyle(),
              );
              break;
            case 3:
              return CupertinoTabView(
                navigatorKey: forthTabNavKey,
                builder: (BuildContext context) => Profile(),
              );
              break;
          }
          return Container();
        },
        tabBar: CupertinoTabBar(
          backgroundColor: C.white,
          height: 87,
          // ignore: unnecessary_const

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
            // back home only if not switching tab
            if (currentIndex == index) {
              switch (index) {
                case 0:
                  firstTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 1:
                  secondTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 2:
                  thirdTabNavKey.currentState!.popUntil((r) => r.isFirst);
                  break;
                case 3:
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
