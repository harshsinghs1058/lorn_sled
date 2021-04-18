import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lorn_sled/main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

var name = "one plus";
var cost = "cost";
var mrp = "mrp";
var discount = "discount";

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null || snapshot.data.docs.toList().length == 0) {
          print("no data");
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Center(
            child: Text(",jnkj"),
          );
        }
      },
    );
  }

  Column _item(int index, BuildContext context, String name, String cost,
      String mrp, String discount) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(
              index.toString(),
            ),
            background: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
              ),
              child: Row(
                children: [
                  Spacer(),
                  SvgPicture.asset("icons/Trash.svg"),
                  SizedBox(
                    width: 35,
                  )
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                print("item tapped");
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
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("images/item1.jpg",
                            errorBuilder: (context, error, stackTrace) {
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
                      child: _productName(
                        context,
                        name,
                        cost,
                        mrp,
                        discount,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 1,
        ),
      ],
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
}
