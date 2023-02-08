import 'package:flutter/material.dart';

class FilterChipData {
  final String label;
  final Color? color;
  final bool isSelected;
  // final double size;
  // final double boxHeight;
  final Color checkmarkColor;
  final Widget avatar;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final TextStyle? labelStyle;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? selectedColor;
  // final FontWeight fontWeight;
  // final FontStyle? fontStyle;
  // final TextAlign? textAlign;
  // final bool? haveBorder;

  const FilterChipData(
      {required this.label,
      this.color,
      this.isSelected = false,
      required this.checkmarkColor,
      required this.avatar,
      this.side,
      this.shape,
      this.labelStyle,
      this.backgroundColor,
      this.disabledColor,
      this.selectedColor
      // this.boxHeight,
      // this.fontStyle,
      // this.fontWeight,
      // this.haveBorder,
      // this.size,
      // this.textAlign
      });

  FilterChipData copy({
    String? label,
    Color? color,
    bool? isSelected,
    // double? size,
    Color? checkmarkColor,
    Widget? avatar,
    BorderSide? side,
    OutlinedBorder? shape,
    TextStyle? labelStyle,
    Color? backgroundColor,
    Color? disabledColor,
    Color? selectedColor,
    // double? boxHeight,
    // FontStyle? fontStyle,
    // FontWeight? fontWeight,
    // bool? haveBorder,
    // TextAlign? textAlign
  }) =>
      FilterChipData(
        label: label ?? this.label,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
        // size: size ?? this.size,
        checkmarkColor: checkmarkColor ?? this.checkmarkColor,
        avatar: avatar ?? this.avatar,
        side: side ?? this.side,
        shape: shape ?? this.shape,
        labelStyle: labelStyle ?? this.labelStyle,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        disabledColor: disabledColor ?? this.disabledColor,
        selectedColor: selectedColor ?? this.selectedColor,
        // boxHeight: boxHeight ?? this.boxHeight,
        // fontStyle: fontStyle ?? this.fontStyle,
        // fontWeight: fontWeight ?? this.fontWeight,
        // haveBorder: haveBorder ?? this.haveBorder,
        // textAlign: textAlign ?? this.textAlign,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterChipData &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          color == other.color &&
          isSelected == other.isSelected &&
          // size == other.size &&
          checkmarkColor == other.checkmarkColor &&
          side == other.side &&
          shape == other.shape &&
          labelStyle == other.labelStyle &&
          backgroundColor == other.backgroundColor &&
          disabledColor == other.disabledColor &&
          selectedColor == other.selectedColor &&
          avatar == other.avatar;

  // boxHeight == other.boxHeight &&
  // fontStyle == other.fontStyle &&
  // fontWeight == other.fontWeight &&
  // haveBorder == other.haveBorder &&
  // textAlign == other.textAlign;

  @override
  int get hashCode => label.hashCode ^ isSelected.hashCode;
}
