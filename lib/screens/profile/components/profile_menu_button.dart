import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({
    Key key,
    @required this.context,
    @required this.svgPath,
    @required this.text,
    @required this.fun,
  }) : super(key: key);

  final BuildContext context;
  final String svgPath;
  final String text;
  final Function fun;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: fun,
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
}
