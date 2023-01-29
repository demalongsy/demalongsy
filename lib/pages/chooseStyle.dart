import 'dart:ui';
import '../custom/toolkit.dart';
import '../custom/widget/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/action_chip_data.dart';
import 'package:demalongsy/models/action_chips.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

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

  // List<ChipData> chips = Chips.all;
  List<ActionChipData> actionChips = ActionChips.all;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
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
                children: actionChips
                    .map((actionChip) => ActionChip(
                          avatar: Icon(
                            actionChip.icon,
                            color: actionChip.iconColor,
                          ),
                          backgroundColor: Colors.grey[200],
                          label: Text(actionChip.label),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                          // onPressed: () => Utils.showSnackBar(
                          //   context,
                          //   'Do action"${actionChip.label}"...',
                          // ),
                        ))
                    .toList(),
              )
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