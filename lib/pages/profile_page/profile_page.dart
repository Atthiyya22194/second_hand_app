import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';
import '../../widgets/rounded_button.dart';
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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const UserProfile(), const ProfileMenu(), Container()],
        ),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const PoppinsText(
      text: 'My Account',
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const ListMenu(
            icon: CupertinoIcons.pencil_ellipsis_rectangle,
            title: 'Edit Profile',
            page: EditProfilePage()),
        const ListMenu(
            icon: CupertinoIcons.cart, title: 'My Order', page: MyOrderPage()),
        const ListMenu(
            icon: CupertinoIcons.cube_box,
            title: 'My Products',
            page: MyProductPage()),
        SizedBox(
            width: double.infinity,
            child: RoundedButton(
                text: 'Logout', onPressed: () => _logout(context)))
      ],
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
