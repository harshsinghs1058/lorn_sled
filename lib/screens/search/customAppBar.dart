import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:badges/badges.dart';

class CustomAppBar extends PreferredSize {
  @override
  final Size preferredSize = Size.fromHeight(70);
  final TextEditingController _searchController;

  CustomAppBar(this._searchController);

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
            child: Row(
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    }),
                Container(
                  width: getProportionateScreenWidth(290),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (String value) {
                      _searchController.text = value.toLowerCase();
                      print(_searchController.text);
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
              ],
            ),
          ),
        ),
      );
}
