import 'package:flutter/material.dart';
import 'package:lorn_sled/screens/profile/components/profilePic.dart';

import 'menuProfile.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
          ),
          Spacer(),
          ProfilePic(),
          Spacer(),
          ProfileMenu(),
          Spacer(),
        ],
      ),
    );
  }
}
