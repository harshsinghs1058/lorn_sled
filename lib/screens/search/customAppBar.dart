import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:badges/badges.dart';

class CustomAppBar extends PreferredSize {
  @override
  final Size preferredSize = Size.fromHeight(70);
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Theme(
          data: ThemeData(primarySwatch: Colors.amber),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            height: 100,
            child: Container(
              width: getProportionateScreenWidth(260),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                onSubmitted: (String value) {
                  print("submitted");
                  print(value);
                },
                textInputAction: TextInputAction.go,
                style: Theme.of(context).textTheme.headline6,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
