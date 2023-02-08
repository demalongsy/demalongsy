import 'package:flutter/material.dart';
import 'package:demalongsy/widget/action_chip_data.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../custom/toolkit.dart';
import '../custom/widget/font.dart';

class FilterChips {
  static final all = <FilterChipData>[
    FilterChipData(
        label: 'Vintage 90s',
        isSelected: false,
        // color: C.dangerDefault,
        checkmarkColor: C.dark1,
        labelStyle: const TextStyle(color: C.dark1, fontFamily: 'Poppins'),
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // ),

        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
      label: 'All black',
      isSelected: false,
      // color: Colors.transparent,
      checkmarkColor: C.dark1,
      avatar: SvgPicture.asset('assets/images/circle-regular.svg'),
    ),
    FilterChipData(
        label: 'American',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        backgroundColor: C.dark1,
        //   child: Icon(Icons.call),
        // )
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Minimal',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // )
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Fairy',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // ),
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Korean',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // ),
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Y2K',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // ),
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Boyish',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // )
        avatar: SvgPicture.asset('assets/images/circle-regular.svg')),
    FilterChipData(
        label: 'Business',
        isSelected: false,
        // color: Colors.transparent,
        checkmarkColor: C.dark1,
        // avatar: CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   child: Icon(Icons.call),
        // ),
        avatar: SvgPicture.asset('assets/images/circle-regular.svg'))
  ];
}
