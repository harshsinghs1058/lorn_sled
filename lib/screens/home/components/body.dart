import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DiscountBanner(),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  "Special for you",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                ),
              ),
            ),
            PopularProducts(),
            // SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
