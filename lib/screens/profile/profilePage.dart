import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';

import 'components/body.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

int index = 0;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customHomePageAppBar(context),
      body: Body(),
    );
  }

  AppBar customHomePageAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10,
      centerTitle: true,
      title: Text(
        "Profile",
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 22),
      ),
      leading: TextButton(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 22,
        ),
        onPressed: () {},
      ),
    );
  }
}
