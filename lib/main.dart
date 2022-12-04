import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/login_page/login_page.dart';
import 'package:second_hand_app/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  print(accessToken);
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
  final String? accessToken;
  const MyApp({Key? key, this.accessToken}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _sessionCheck(accessToken),
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
