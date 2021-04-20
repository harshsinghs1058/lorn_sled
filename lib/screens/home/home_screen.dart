import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/color.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/cart/cartPage.dart';
import 'package:lorn_sled/screens/profile/components/menuProfile.dart';
import 'package:lorn_sled/screens/profile/components/profilePic.dart';
import 'package:lorn_sled/screens/search/search_page.dart';
import 'components/body.dart';
import 'components/icon_btn_with_counter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 350,
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
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(
              top: getProportionateScreenHeight(10),
              left: getProportionateScreenHeight(10)),
          child: IconBtnWithCounter(
            press: () {
              scaffoldKey.currentState.openDrawer();
            },
            svgSrc: "icons/menu.svg",
          ),
        ),
        title: Text(
          "Lorn Sled",
          style: TextStyle(
            color: kSecondaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: getProportionateScreenHeight(10),
                left: getProportionateScreenHeight(10),
                top: getProportionateScreenHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SearchField(),
                SizedBox(
                  width: 5,
                ),
                IconBtnWithCounter(
                  svgSrc: "icons/Search Icon.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      ),
                    );
                  },
                ),
                IconBtnWithCounter(
                  svgSrc: "icons/Cart Icon.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                ),
                IconBtnWithCounter(
                  svgSrc: "icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      body: Body(),
    );
  }
}
