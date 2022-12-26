import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'poppins_text.dart';

class RoundedTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hint;
  final ValueChanged<String>? onSubmited;
  const RoundedTextField(
      {super.key,
      required this.hint,
      required this.title,
      this.controller,
      this.onSubmited});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
              child: PoppinsText(text: title)),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 16 * ffem,
                fontWeight: FontWeight.w400,
                height: 1.4285714286 * ffem / fem,
                color: const Color(0xff8a8a8a),
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xffd0d0d0),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xffd0d0d0),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onSubmitted: onSubmited,
          )
        ],
      ),
    );
  }
}
