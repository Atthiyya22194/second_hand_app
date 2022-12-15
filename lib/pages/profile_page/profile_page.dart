import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/login_page/login_page.dart';
import 'package:second_hand_app/widgets/list_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/show_snack_bar.dart';
import '../my_product_page/my_product_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ListMenu(title: 'My Products', page: MyProductPage()),
          ElevatedButton(
              onPressed: () => _logout(context), child: const Text('Logout'))
        ],
      ),
    );
  }
}

_logout(dynamic context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('accessToken');

  showSnackBar(context, "Successfully Logout!", "You have Successfully logout",
      ContentType.success);

  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
