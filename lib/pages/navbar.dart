import 'package:demalongsy/pages/login.dart';
import 'package:demalongsy/pages/profile.dart';
import 'package:demalongsy/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/pages/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final screen = [HomePage(), Search(), Login(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24.0),
            topLeft: Radius.circular(24.0),
          ),
          color: Color(0xFFFFFFFF),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: SizedBox(
            height: 86,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 36.0, right: 36.0, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                    child: _selectedIndex == 0
                        ? SvgPicture.asset(
                            'assets/images/homeFo.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1,
                          )
                        : SvgPicture.asset(
                            'assets/images/homeDe.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1.withOpacity(0.5),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: _selectedIndex == 1
                        ? SvgPicture.asset(
                            'assets/images/magnifying.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1,
                          )
                        : SvgPicture.asset(
                            'assets/images/magnifying.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1.withOpacity(0.5),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: _selectedIndex == 2
                        ? SvgPicture.asset(
                            'assets/images/laundryFo.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1,
                          )
                        : SvgPicture.asset(
                            'assets/images/laundryDe.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1.withOpacity(0.5),
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    child: _selectedIndex == 3
                        ? SvgPicture.asset(
                            'assets/images/user-solid.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1,
                          )
                        : SvgPicture.asset(
                            'assets/images/user-regular.svg',
                            height: 25,
                            width: 25,
                            color: C.dark1.withOpacity(0.5),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
