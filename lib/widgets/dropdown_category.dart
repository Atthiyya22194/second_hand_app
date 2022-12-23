

import 'package:flutter/material.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';

class DropdownCategory extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onchanged;
  const DropdownCategory(
      {super.key, required this.value, required this.items, this.onchanged});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PoppinsText(text: 'Select Category'),
        Container(
          padding: EdgeInsets.fromLTRB(8 * fem, 4 * fem, 8 * fem, 4 * fem),
          margin: EdgeInsets.fromLTRB(0 * fem, 4 * fem, 0 * fem, 8 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            border: Border.all(
              color: const Color(0xffd0d0d0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                borderRadius: BorderRadius.circular(20.0),
                value: value,
                hint: const Text('Select Category'),
                items: items,
                onChanged: onchanged),
          ),
        )
      ],
    );
  }
}