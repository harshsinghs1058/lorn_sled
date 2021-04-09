import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/home%20page/customAppBar.dart';
import 'package:lorn_sled/screens/itemView/itemView.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.data == null ||
              snapshot.data.docs.toList().length == 0) {
            print("no data");
            return Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 40),
              ),
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
                    child: InkWell(
                      splashColor: Colors.green,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Center(
                                      child: ItemView(
                                        description: json
                                            .decode(document["description"]),
                                        discount: discount,
                                        name: name,
                                        rating: document["rating"],
                                        mrp: mrp,
                                        sCost: cost, image: images,
                                      ),
                                    )));
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
                                border:
                                    Border.all(color: Colors.black, width: 2),
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
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
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
                                        .copyWith(
                                            fontSize: 20, color: Colors.black),
                                  ),
                                  Text(
                                    "Rs. " + cost.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
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
                                          text: "  " +
                                              discount.toString() +
                                              "% off",
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.green[600],
                                            fontSize: 20,
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
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }
}
