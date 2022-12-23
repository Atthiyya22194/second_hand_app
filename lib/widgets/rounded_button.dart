import 'package:flutter/material.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const RoundedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
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
      child: PoppinsText(
        text: text,
        fontSize: 14,
        color: const Color(0xFFFFFFFF),
      ),
    );
  }
}
