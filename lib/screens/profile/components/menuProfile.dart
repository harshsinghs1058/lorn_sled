import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenu extends StatefulWidget {
  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  Padding profileMenuButton(BuildContext context, String svgPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: 10,
            ),
            SvgPicture.asset(
              svgPath,
              height: 22,
              color: Color(0xffe65449),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 20, color: Colors.black),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            )
          ],
        ),
        style: TextButton.styleFrom(
          backgroundColor: Color(0xFFF5F6F9),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          profileMenuButton(context, "icons/User.svg", "My Account"),
          profileMenuButton(context, "icons/Heart Icon.svg", "Wish List"),
          profileMenuButton(context, "icons/Settings.svg", "Setting"),
          profileMenuButton(context, "icons/Chat bubble Icon.svg", "Help"),
          profileMenuButton(context, "icons/Log out.svg", "Log out"),
        ],
      ),
    );
  }
}
