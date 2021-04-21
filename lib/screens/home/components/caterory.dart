import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/itemView/itemView.dart';

class Category extends StatefulWidget {
  final category;

  const Category({Key key, @required this.category}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mobiles",
          style: TextStyle(
            color: Colors.yellowAccent,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade700,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where("category", isEqualTo: widget.category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null) {
            print("no data");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data.docs.toList().length == 0) {
            return Center(
              child: Text("No data Found"),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map(
                (document) {
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
                                    document: document,
                                    description:
                                        json.decode(document["description"]),
                                    discount: discount,
                                    name: name,
                                    rating: document["rating"],
                                    ratingCount: document["ratingCount"],
                                    mrp: mrp,
                                    sCost: cost,
                                    image: images,
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
                                _productImage(images),
                                SizedBox(
                                  width: 20,
                                ),
                                _productName(
                                    context, name, cost, mrp, discount),
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
    );
  }

  Container _productName(
      BuildContext context, String name, cost, mrp, discount) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width - 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontSize: 18, color: Colors.black),
          ),
          Text(
            "Rs. " + cost.toString(),
            style: Theme.of(context).textTheme.bodyText1.copyWith(
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
                decoration: TextDecoration.lineThrough,
              ),
              children: [
                TextSpan(
                  text: "  " + discount.toString() + "% off",
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
    );
  }

  Container _productImage(List images) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(images[0],
            errorBuilder: (context, error, stackTrace) {
          print(error);
          return Center(
            child: Text("Image unavilable"),
          );
        }),
      ),
    );
  }
}
