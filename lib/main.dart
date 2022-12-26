import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/login_page/login_page.dart';
import 'widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.accessToken}) : super(key: key);

  final String? accessToken;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second Hand',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          iconTheme: IconThemeData(
            color: Color(
              0xFF151515,
            ),
          ),
        ),
      ),
      home: Container(
          color: CupertinoColors.white,
          child: SafeArea(child: _sessionCheck(accessToken))),
    );
  }
}

_sessionCheck(String? accessToken) {
  if (accessToken != null) {
    return const BottomNavBar();
  } else {
    return const LoginPage();
  }
}
