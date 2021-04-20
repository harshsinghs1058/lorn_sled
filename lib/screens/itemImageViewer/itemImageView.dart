import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';

// ignore: must_be_immutable
class ItemImageView extends StatefulWidget {
  final List itemImages;
  final String rating;
  int idx;
  ItemImageView({
    @required this.itemImages,
    @required this.rating,
    @required this.idx,
  });
  @override
  _ItemImageViewState createState() => _ItemImageViewState();
}

class _ItemImageViewState extends State<ItemImageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white.withOpacity(0.8),
          child: _buildImageListView(),
        ),
        body: _buildZoomableImage(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Center(
          child: Text(
            (widget.rating == "null" ? 0 : widget.rating).toString() + "  ",
            style: TextStyle(fontSize: 20),
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

//zoomable widget with pinch
  Container _buildZoomableImage() {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(610),
      child: InteractiveViewer(
        maxScale: 10.0,
        minScale: 1.0,
        panEnabled: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: ClipRRect(
              child: Image.network(
                widget.itemImages[widget.idx],
              ),
            ),
          ),
        ),
      ),
    );
  }

//horizontal list view wiget to display all item images
  Container _buildImageListView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(25)),
      height: getProportionateScreenHeight(100),
      child: ListView.builder(
        semanticChildCount: widget.idx,
        itemCount: widget.itemImages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(10)),
          padding: EdgeInsets.all(getProportionateScreenHeight(5)),
          child: InkWell(
            onTap: () {
              setState(() {
                widget.idx = index;
              });
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                width: getProportionateScreenHeight(80),
                child: Image.network(
                  widget.itemImages[index],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
