import 'package:flutter/material.dart';
import 'package:demalongsy/models/action_chip_data.dart';

class ActionChips {
  static final all = <ActionChipData>[
    ActionChipData(
        label: 'Y2k', icon: Icons.music_note, iconColor: Colors.orange),
    ActionChipData(label: 'Minimal', icon: Icons.call, iconColor: Colors.red),
    ActionChipData(label: 'Street', icon: Icons.alarm, iconColor: Colors.green),
    ActionChipData(label: 'สายฝอ', icon: Icons.check, iconColor: Colors.blue),
    ActionChipData(label: 'Korean', icon: Icons.bed, iconColor: Colors.black),
  ];
}
