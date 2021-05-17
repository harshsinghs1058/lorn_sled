import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/color.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/orders/order_page.dart';
import 'package:lorn_sled/screens/wishlist_page/wishList.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    temp();
  }

  Future<void> temp() async {
    showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            InputDecoration(hintText: "Please Enter Text"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Choice Box"),
                          Checkbox(
                              value: isChecked,
                              onChanged: (checked) {
                                setState(() {
                                  isChecked = checked;
                                });
                              })
                        ],
                      )
                    ],
                  )),
              title: Text('Stateful Dialog'),
              actions: <Widget>[
                InkWell(
                  child: Text('OK   '),
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          });
        });
  }

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
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 250, 250, 250),
        leading: Padding(
          padding: EdgeInsets.only(
            top: getProportionateScreenHeight(10),
            left: getProportionateScreenHeight(10),
          ),
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
              top: getProportionateScreenHeight(10),
              bottom: getProportionateScreenHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                SizedBox(
                  width: 5,
                ),
                IconBtnWithCounter(
                  svgSrc: "icons/Cart Icon.svg",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                IconBtnWithCounter(
                  svgSrc: "icons/Bell.svg",
                  numOfitem: 3,
                  press: () {},
                ),
                SizedBox(
                  width: 5,
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
