import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/itemImageViewer/itemImageView.dart';

//imported variables
//program variables
int _index = 0;

class ItemView extends StatefulWidget {
  final List description;
  final List image;
  final String rating;
  final int mrp;
  final int sCost;
  final String name;
  final discount;
  ItemView({
    @required this.description,
    @required this.image,
    @required this.rating,
    @required this.mrp,
    @required this.sCost,
    @required this.name,
    @required this.discount,
  });
  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        bottomNavigationBar: _buildBottomAppBar(),
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
            ],
          ),
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
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Center(
          child: Text(
            (widget.rating == "null" ? 0 : widget.rating).toString() + " ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          width: 20,
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

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
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
          Flexible(
            child: Container(
              height: 50,
              color: Colors.yellow,
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
