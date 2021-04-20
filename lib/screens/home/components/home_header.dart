import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/color.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends PreferredSize {
  final Size preferredSize = Size.fromHeight(100);
  final scaffoldDrawer;
  HomeHeader(this.scaffoldDrawer);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
            right: getProportionateScreenHeight(20),
            left: getProportionateScreenHeight(10),
            top: getProportionateScreenHeight(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                scaffoldDrawer.currentState.openDrawer();
              },
              child: Container(
                child: Icon(
                  Icons.menu,
                ),
                padding: EdgeInsets.all(getProportionateScreenWidth(12)),
                height: getProportionateScreenWidth(46),
                width: getProportionateScreenWidth(46),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SearchField(),
            IconBtnWithCounter(
              svgSrc: "icons/Cart Icon.svg", press: () {},
              // press: () => Navigator.pushNamed(context, CartScreen.routeName),
            ),
            IconBtnWithCounter(
              svgSrc: "icons/Bell.svg",
              numOfitem: 3,
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
