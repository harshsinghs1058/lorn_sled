import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/itemImageViewer/itemImageView.dart';

//imported variables
List<String> _itemImages = [
  "images/item1.jpg",
  "images/item2.jpg",
  "images/item3.jpg",
  "images/item4.jpg",
  "images/item5.jpg",
  "images/item6.jpg",
];
List<String> _description = [
  "Rear Quad Camera with 48 MP Sony IMX586 Sensor, 16 MP Ultra Wide Angle, 5 MP macro lens and 2 MP monochrome lens | Front Camera with 16 MP Sony IMX471 Sensor",
  "6.55 inch ( 16.63 centimeters) 120 Hz Fluid AMOLED Display with 2400 X 1080 Pixels resolution, 402 PPI density",

  "2.86 GHz Qualcomm Snapdragon 865 Octa-core Processor + Adreno 650 GPU , Oxygen OS based on Android 11 Operating system",
  "12 GB RAM | 256 GB ROM",
  "4500 mAH Lithium-ion battery with 65 W “Warp charge”",
  "1 year Manufacturer warranty for Device, Battery and in-box Accessories from the date of purchase",
  "Box also includes: OnePlus 8T,Warp Charge 65 Power Adapter, Warp Charge Type-C to Type-C Cable, Quick Start Guide, Welcome Letter, Safety Information and Warranty Card, LOGO Sticker, Case, Screen Protector, SIM Tray Ejector",

  // Important features: Face Unlock, HDR, Screen Flash, Face Retouching, CINE Aspect Ratio Video Recording, Video Portrait, UltraShot HDR, Nightscape, Macro, Portrait, Pro Mode, Panorama, Smart Pet Capture, AI Scene Detection, RAW Image, Filter, Video Focus Tracking, Super Stable, Video Nightscape, Dual Stereo Speakers, Noise cancellation support, Dolby Atmos
  // supports Alexa Hands-Free. Alexa on your phone lets you make phone calls, open apps, control smart home devices, access the library of Alexa skills, and more using just your voice while on-the-go. Download the Alexa app and complete hands-free setup to get started. Just ask - and Alexa will respond instantly.
];
double rating = 5.0;
int mrp = 40000;
int sCost = 35999;
String name = "OnePlus 8T(256GB, 8GB RAM)";
//program variables
int _index = 0;

class ItemView extends StatefulWidget {
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
            name,
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              text: "Rs." + sCost.toString() + " ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
              children: [
                TextSpan(
                  text: mrp.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                TextSpan(
                  text: "  " +
                      (((mrp - sCost) / mrp) * 100).toStringAsFixed(2) +
                      "% off",
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
        itemCount: _itemImages.length,
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
        itemCount: _itemImages.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ItemImageView(
                    itemImages: _itemImages,
                    rating: rating,
                    idx: _index,
                  ),
                ),
              );
            },
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  _itemImages[index],
                ),
              ),
            ),
            // ),
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
            rating.toString() + "  ",
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
    for (int i = 0; i < _description.length; i++) {
      _ans.add(
        TableRow(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " " + String.fromCharCode(0x2022) + " ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontSize: 28),
                ),
                Container(
                  width: getProportionateScreenWidth(300),
                  child: Text(
                    _description[i],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
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
            style: Theme.of(context).textTheme.headline2,
          ),
          Table(
            children: _ans,
          ),
        ],
      ),
    );
  }
}
