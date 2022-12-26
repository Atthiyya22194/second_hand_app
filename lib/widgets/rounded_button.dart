import 'package:flutter/material.dart';

import 'poppins_text.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, required this.text, required this.onPressed});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff7126b5),
        ),
      ),
      onPressed: onPressed,
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 8 * fem, 0 * fem, 8 * fem),
        child: PoppinsText(
          text: text,
          fontSize: 14,
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
