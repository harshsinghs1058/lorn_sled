import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/cart/cartPage.dart';
import 'package:lorn_sled/screens/itemImageViewer/itemImageView.dart';
import 'package:lorn_sled/main.dart';
import 'package:toast/toast.dart';

//imported variables
//program variables
int _index = 0;

class ItemView extends StatefulWidget {
  final List description;
  final List image;
  final String rating;
  final int mrp;
  final int sCost;
  final int ratingCount;
  final String name;
  final discount;
  final document;
  final cartView;
  ItemView({
    @required this.description,
    @required this.image,
    @required this.rating,
    @required this.mrp,
    @required this.sCost,
    @required this.name,
    @required this.discount,
    @required this.ratingCount,
    @required this.document,
    this.cartView = true,
  });
  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildBottomAppBar(widget.document, widget.cartView),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            _buildImageView(),
            _buildDotsForPageView(),
            _buildPriceDetails(context),
            _buildDescription(),
            Divider(),
            Container(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rate Product : ",
                        style: TextStyle(fontSize: 26),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.rating,
                            style: TextStyle(fontSize: 40),
                          ),
                          Icon(
                            Icons.star,
                            size: 40,
                          ),
                        ],
                      ),
                      Text(
                        "${widget.ratingCount} Rating's",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      print("add rating");
                      // showDialog(
                      //   child: RatingBar.builder(
                      //     initialRating: 3,
                      //     minRating: 1,
                      //     direction: Axis.horizontal,
                      //     allowHalfRating: true,
                      //     itemCount: 5,
                      //     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      //     itemBuilder: (context, _) => Icon(
                      //       Icons.star,
                      //       color: Colors.amber,
                      //     ),
                      //     onRatingUpdate: (rating) {
                      //       print(rating);
                      //     },
                      //   ),
                      // );
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(10.0),
                      elevation: 10,
                      shadowColor: Color(0xFFFF8C3B),
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }

  Container _buildPriceDetails(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(350),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: "Rs." + widget.sCost.toString() + "  ",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 24,
              ),
              children: [
                TextSpan(
                  text: "Rs. " + widget.mrp.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "  " + widget.discount.toString() + "% off",
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Container _buildDotsForPageView() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      height: 23,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.image.length,
        itemBuilder: (context, index) => Container(
          height: 13,
          width: 13,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: index == _index ? Colors.red : Colors.grey,
            borderRadius: BorderRadius.circular(75),
          ),
        ),
      ),
    );
  }

  Container _buildImageView() {
    return Container(
      height: getProportionateScreenWidth(350),
      child: PageView.builder(
        onPageChanged: (int index) {
          setState(
            () {
              _index = index;
            },
          );
        },
        itemCount: widget.image.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemImageView(
                    itemImages: widget.image,
                    rating: widget.rating,
                    idx: _index,
                  ),
                ),
              );
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.image[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 10,
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Center(
          child: Text(
            (widget.rating).toString() + " ",
            style: TextStyle(
              fontSize: 26,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 26,
          child: Image.asset(
            "icons/star.jpg",
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  BottomAppBar _buildBottomAppBar(document, bool showCart) {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              color: Colors.yellow,
              height: 50,
              child: Center(
                child: Text(
                  "Buy Now",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          if (showCart)
            Flexible(
              child: InkWell(
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('cart')
                      .doc("userUid")
                      .collection("products")
                      .doc(document["name"])
                      .set({
                    "name": document["name"],
                    "category": document["category"],
                    "cost": document["cost"],
                    "count": document["count"],
                    "description": document["description"],
                    "discount": document["discount"],
                    "image": document["image"],
                    "mrp": document["mrp"],
                    "nameSearch": document["nameSearch"],
                    "rating": document["rating"],
                    "ratingCount": document["ratingCount"],
                  });
                  Toast.show("Product added to cart", context);

                  print("Product added to firebase");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    List<TableRow> _ans = [];
    for (int i = 0; i < widget.description.length; i++) {
      _ans.add(
        TableRow(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5.50,
                        right: 4,
                      ),
                      child: CircleAvatar(
                        maxRadius: 4,
                        backgroundColor: Colors.black87,
                      ),
                    ),
                    Container(
                      width: getProportionateScreenWidth(300),
                      child: Text(
                        widget.description[i].toString(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      width: getProportionateScreenWidth(350),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description : ",
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.amber,
                ),
          ),
          Divider(),
          Table(
            children: _ans,
          ),
        ],
      ),
    );
  }
}
