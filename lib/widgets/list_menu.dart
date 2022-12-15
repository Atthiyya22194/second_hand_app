import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListMenu extends StatelessWidget {
  final String title;
  final Widget page;
  const ListMenu({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: size.width,
        color: CupertinoColors.lightBackgroundGray,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), const Icon(CupertinoIcons.arrow_right)]),
        ),
      ),
    );
  }
}
