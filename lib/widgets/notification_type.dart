import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationType extends StatelessWidget {
  final String type;
  final Widget page;
  const NotificationType({super.key, required this.type, required this.page});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: size.width,
        color: CupertinoColors.lightBackgroundGray,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(type), const Icon(CupertinoIcons.arrow_right)]),
        ),
      ),
    );
  }
}
