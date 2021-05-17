import 'package:flutter/material.dart';
import 'package:lorn_sled/screens/profile/components/profile_menu_button.dart';
import 'package:lorn_sled/screens/wishlist_page/wishList.dart';
import 'package:lorn_sled/screens/wrapper/wrapper.dart';
import "package:lorn_sled/services/auth.dart";

class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProfileMenuButton(
              context: context,
              svgPath: "icons/User.svg",
              text: "My Account",
              fun: () {}),
          ProfileMenuButton(
            context: context,
            svgPath: "icons/Heart Icon.svg",
            text: "Wish List",
            fun: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => WishList()));
            },
          ),
          ProfileMenuButton(
              context: context,
              svgPath: "icons/Settings.svg",
              text: "Setting",
              fun: () {}),
          ProfileMenuButton(
              context: context,
              svgPath: "icons/Chat bubble Icon.svg",
              text: "Help",
              fun: () {}),
          ProfileMenuButton(
              context: context,
              svgPath: "icons/Log out.svg",
              text: "Log out",
              fun: () {
                Auth().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Wrapper()));
              }),
        ],
      ),
    );
  }
}
