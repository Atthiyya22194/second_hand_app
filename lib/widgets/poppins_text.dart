import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PoppinsText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  const PoppinsText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.height});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Text(
      text ?? "Something went wrong",
      style: GoogleFonts.poppins(
        fontSize: fontSize ?? 14 * ffem,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: height ?? 1.4285714286 * ffem / fem,
        color: color ?? const Color(0xff151515),
      ),
    );
  }
}
