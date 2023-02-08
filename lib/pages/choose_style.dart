import 'dart:ui';
import 'package:demalongsy/custom/widget/component.dart';
import 'package:demalongsy/pages/navbar.dart';
import '../custom/toolkit.dart';
import '../custom/widget/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../widget/action_chip_data.dart';
import 'package:demalongsy/models/action_chips.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
// class Language {
//   final int id;
//   final String name;

//   Language({
//     this.id,
//     this.name,
//   });
// }

class ChooseStyle extends StatefulWidget {
  const ChooseStyle({super.key});
// TestMultiSelectLib({Key key, this.title}) : super(key: key);
  // final String title;
  @override
  State<ChooseStyle> createState() => _ChooseStyleState();
  // _TestMultiSelectLibState createState() => _TestMultiSelectLibState();
}

class _ChooseStyleState extends State<ChooseStyle> {
  // static List<Language> _languages = [
  //   Language(id: 1, name: "Python"),
  //   Language(id: 2, name: "TypeScript"),
  //   Language(id: 3, name: "Dart"),
  //   Language(id: 4, name: "JavaScript"),
  //   Language(id: 5, name: "Java"),
  // ];
  // final _items = _languages
  //     .map((language) => MultiSelectItem<Language>(language, language.name))
  //     .toList();

  // List<Language> _selectedLanguages = [];

  // final _multiSelectKey = GlobalKey<FormFieldState>();

  int index = 0;
  final double spacing = 8;
  List favUserSelect = [];

  // List<ChipData> chips = Chips.all;
  List<FilterChipData> filterChips = FilterChips.all;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: C.white,
          appBar: AppBar(
            backgroundColor: C.white,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Column(
            //padding วางตรงนี้เป็นต้นไป
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spectral(
                text: "Choose",
                color: C.dark1,
                fontWeight: FW.bold,
                size: 36,
              ),
              const Spectral(
                text: "your favorite style",
                color: C.dark1,
                fontWeight: FW.bold,
                size: 36,
              ),
              const Spectral(
                text: "Fantastic to start to use application!",
                color: C.dark1,
                fontWeight: FW.light,
                size: 14,
              ),
              Wrap(
                runSpacing: spacing,
                spacing: spacing,
                children: filterChips
                    .map((filterChip) => FilterChip(
                          label: Text(filterChip.label),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: filterChip.selectedColor,
                          ),
                          avatar: filterChip.avatar,
                          backgroundColor: filterChip.selectedColor,
                          onSelected: (isSelected) => setState(() {
                            filterChips = filterChips.map((otherChip) {
                              if (filterChip == otherChip &&
                                  filterChip.isSelected == false) {
                                favUserSelect.add(otherChip.label);
                                print(favUserSelect);
                                print(filterChip.isSelected);
                                return filterChip.copy(
                                  isSelected: isSelected,
                                  labelStyle: const TextStyle(
                                      backgroundColor: C.primaryDefault,
                                      fontFamily: 'Poppins'),
                                  avatar: SvgPicture.asset(
                                      'assets/images/circle-check.svg'),
                                  checkmarkColor: C.dark1,
                                  // selectedColor: C.dark1,
                                  color: C.primaryDefault,
                                );
                              } else if (filterChip == otherChip &&
                                  filterChip.isSelected == true) {
                                favUserSelect.remove(otherChip.label);
                                print(favUserSelect);
                                print(filterChip.isSelected);
                                return filterChip.copy(
                                  isSelected: isSelected,
                                  avatar: SvgPicture.asset(
                                      'assets/images/circle-regular.svg'),
                                  backgroundColor: null,
                                  labelStyle: const TextStyle(
                                      backgroundColor: C.primaryDefault,
                                      fontFamily: 'Poppins'),
                                );
                              } else {
                                return otherChip;
                              }
                            }).toList();
                          }),
                          selected: filterChip.isSelected,
                          checkmarkColor: filterChip.checkmarkColor,
                          selectedColor: filterChip.selectedColor,
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 264,
              ),
              favUserSelect.length > 0
                  ? GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Navbar()));
                        // Navigator.of(context).push(
                        // MaterialPageRoute(builder: (context) => HomePage()));
                        //------------------------
                        // Navigator.of(context).push(
                        //   CupertinoPageRoute<bool>(
                        //     fullscreenDialog: true,
                        //     builder: (BuildContext context) => HomePage(),
                        //   ),
                        // );
                      },
                      child: const Button(
                        text: "Get Start",
                        fontWeight: FW.bold,
                        color: C.dark2,
                        size: 16,
                        boxColor: C.secondaryDefault,
                        boxHeight: 48,
                        haveBorder: false,
                      ),
                    )
                  : const Button(
                      text: "Get Start",
                      fontWeight: FW.bold,
                      color: C.dark3,
                      size: 16,
                      boxColor: C.secondaryHover,
                      boxHeight: 48,
                      haveBorder: false,
                    ),
              // MultiSelectChipDisplay(
              //   items: [],
              // decoration: BoxDecoration(
              //   color: Colors.blue.withOpacity(0.1),
              //   borderRadius: BorderRadius.all(Radius.circular(40)),
              //   border: Border.all(
              //     color: Colors.blue,
              //     width: 2,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget builtActionChips()=>Wrap(
//               runSpacing: spacing,
//               spacing: spacing,
//               children: actionChips
//                 .map((actionChip)=>ActionChip(
//                       avatar: Icon(
//                         actionChip.icon
//                         color: actionChip.iconColor,
//                         ),
//                         backgroundColor: Colors.grey[200],
//                         label: Text(actionChip.label),
//                         labelStyle: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black
//                         ),
//                         onPressed: () => Utils.showSnackBar(
//                           context,
//                           'Do action"${actionChip.label}"...',
//                         ),
//                 ))
//                 .toList(),
//             );