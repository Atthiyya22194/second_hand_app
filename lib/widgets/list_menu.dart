import 'package:flutter/material.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';

class ListMenu extends StatelessWidget {
  final String title;
  final Widget page;
  final IconData icon;
  const ListMenu(
      {super.key, required this.title, required this.page, required this.icon});

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
                  child: Icon(icon),
                ),
                PoppinsText(text: title)
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0 * fem, 16 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              height: 1 * fem,
              decoration: const BoxDecoration(
                color: Color(0xffe5e5e5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
