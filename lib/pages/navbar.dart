import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:demalongsy/custom/widget/font.dart';
import 'package:demalongsy/pages/home.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

  final screen = [HomePage(), Container(), Container(), Container()];

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
                        ? const Icon(
                            Icons.home,
                            color: Color(0xFF000000),
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.home_outlined,
                            color: C.disableBackground,
                            size: 30.0,
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: _selectedIndex == 1
                        ? const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF000000),
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.search_rounded,
                            color: C.disableBackground,
                            size: 30.0,
                          ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: const Icon(
                      Icons.rocket_launch_rounded,
                      color: C.disableBackground,
                      size: 30.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 3;
                      });
                    },
                    child: _selectedIndex == 3
                        ? const Icon(
                            Icons.person,
                            color: Color(0xFF000000),
                            size: 30.0,
                          )
                        : const Icon(
                            Icons.person_outline_rounded,
                            color: C.disableBackground,
                            size: 30.0,
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
