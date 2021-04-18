import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
// import 'package:shop_app/components/coustom_bottom_nav_bar.dart';

import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
