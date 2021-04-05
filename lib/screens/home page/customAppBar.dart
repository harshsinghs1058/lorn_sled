import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:badges/badges.dart';

class CustomAppBar extends PreferredSize {
  @override
  final Size preferredSize = Size.fromHeight(70);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 15),
          height: 50,
          child: Row(
            children: [
              Container(
                width: getProportionateScreenWidth(260),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  style: Theme.of(context).textTheme.headline6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Badge(
                badgeContent: Text('3'),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Badge(
                badgeContent: Text('3'),
                child: Icon(
                  Icons.notifications_none,
                  size: 35,
                ),
              )
            ],
          ),
        ),
      );
}
