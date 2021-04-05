import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/cart/cartBody.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customCartPageAppBar(context),
      backgroundColor: Colors.white,
      body: Body(),
      bottomNavigationBar: buildBottomAppBar(context),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 55,
        child: Row(
          children: [
            Container(
              color: Color(0xff6386f7),
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  "Total Rs. 455",
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 22,
                      ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                color: Color(0xff57cf73),
                width: MediaQuery.of(context).size.width / 2,
                child: Center(
                  child: Text(
                    "Buy Now",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 22,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar customCartPageAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 10,
      centerTitle: true,
      title: Text(
        "My Cart",
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
