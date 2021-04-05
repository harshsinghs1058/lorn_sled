import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: AssetImage(
            "images/icon.png",
          ),
        ),
        Positioned(
          bottom: 15,
          left: 130,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                "icons/Camera Icon.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
