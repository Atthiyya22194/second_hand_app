import 'package:flutter/material.dart';

import 'poppins_text.dart';

class ListMenu extends StatelessWidget {
  const ListMenu(
      {super.key, required this.title, required this.page, required this.icon});

  final IconData icon;
  final Widget page;
  final String title;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 16 * fem, 0 * fem, 8 * fem),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 8 * fem, 0 * fem),
                  child: Icon(
                    icon,
                    color: const Color(0xff7126b5),
                  ),
                ),
                PoppinsText(text: title)
              ],
            ),
            Divider(
              color: const Color(
                0xffe5e5e5,
              ),
              thickness: 1 * fem,
            )
          ],
        ),
      ),
    );
  }
}
