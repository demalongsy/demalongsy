import 'package:flutter/material.dart';
import 'package:demalongsy/custom/toolkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

//Widget button for GestureDetector!
class Button extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final double boxHeight;
  final Color boxColor;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final double? letterspacing;
  final TextAlign? textAlign;
  final bool? haveBorder;

  const Button(
      {Key? key,
      required this.text,
      required this.size,
      required this.color,
      required this.fontWeight,
      required this.boxColor,
      required this.boxHeight,
      this.fontStyle = FontStyle.normal,
      this.letterspacing,
      this.haveBorder,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(50),
        border:
            haveBorder == true ? Border.all(width: 1, color: C.dark2) : null,
      ),
      height: boxHeight,
      child: Center(
          child: Text(
        text,
        textAlign: textAlign,
        style: GoogleFonts.poppins(
          fontSize: size,
          color: color,
          fontWeight: fontWeight,
          letterSpacing: letterspacing,
        ),
      )),
    );
  }
}

class InputField extends StatefulWidget {
  final double? size;
  final String text;
  final Color? color;
  final Color? borderColor;
  final double? boxHeight;
  final Color? boxColor;
  final FontWeight? fontWeight;
  final bool? haveBorder;
  final String? stateButton;
  final FontStyle? fontStyle;

  const InputField(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.borderColor,
      this.fontWeight,
      this.boxColor,
      this.boxHeight,
      this.haveBorder,
      this.stateButton,
      this.fontStyle})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: C.disableField,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: C.disableField),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: C.infoDefault),
            borderRadius: BorderRadius.circular(8),
          ),
          // contentPadding: EdgeInsets.symmetric(vertical: 36),
          hintText: widget.text,
          hintStyle: TextStyle(color: C.disableTextfield),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: SvgPicture.asset(
              'assets/images/search-icon-grey.svg',
              alignment: Alignment.center,
              fit: BoxFit.fill,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
            ),
          ),
          suffixIcon: const Align(
            widthFactor: 0.5,
            heightFactor: 1.0,
            child: Icon(
              Icons.close,
            ),
          ),
        ),
        style: GoogleFonts.poppins(
          fontSize: widget.size,
          color: widget.color,
          fontWeight: widget.fontWeight,
        ),
      ),
    );
  }
}
