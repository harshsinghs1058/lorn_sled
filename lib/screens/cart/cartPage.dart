import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/itemView/itemView.dart';
import 'package:lorn_sled/main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

bool showBottonNavigatorBar = true;
int total = 0;
Set<String> temp = {};

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customCartPageAppBar(context),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc("userUid")
            .collection("products")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            print("no data");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.docs.toList().length == 0) {
            return Center(
              child: Text(
                "CART IS EMPTY",
                style: TextStyle(fontSize: 30),
              ),
            );
          } else {
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: snapshot.data.docs.map(
                (document) {
                  if (!temp.contains(document["name"]))
                    total += int.parse(document["cost"].toString());
                  temp.add(document["name"]);
                  print(total);
                  List images = json.decode(document["image"]);
                  String name = document["name"];
                  var cost = document["cost"];
                  var mrp = document["mrp"];
                  var discount = document["discount"];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Column(
                      children: [
                        InkWell(
                          splashColor: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Center(
                                  child: ItemView(
                                    description:
                                        json.decode(document["description"]),
                                    discount: discount,
                                    name: name,
                                    rating: (document["rating"]).toString(),
                                    ratingCount: (document["rating"]),
                                    mrp: mrp,
                                    sCost: cost,
                                    image: images,
                                    document: document,
                                    cartView: false,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(images[0],
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                      print(error);
                                      return Center(
                                        child: Text("Image unavilable"),
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                      ),
                                      Text(
                                        "Rs. " + cost.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              fontSize: 18,
                                              color: Colors.redAccent,
                                            ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Rs. " + mrp.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "  " +
                                                  discount.toString() +
                                                  "% off",
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.green[600],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          }
        },
      ),
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
                  "Total Rs. " + total.toString(),
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
        onPressed: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
