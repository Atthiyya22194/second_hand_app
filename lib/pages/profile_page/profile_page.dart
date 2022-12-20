import 'package:flutter/material.dart';
import '../my_order_page/my_order_page.dart';
import '../edit_profile_page/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/list_menu.dart';
import '../login_page/login_page.dart';
import '../my_product_page/my_product_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ListMenu(title: 'Edit Profile', page: EditProfilePage()),
          const ListMenu(title: 'My Order', page: MyOrderPage()),
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

  Navigator.of(context, rootNavigator: true).push(
    MaterialPageRoute(
      builder: (context) => const LoginPage(),
    ),
  );
}
