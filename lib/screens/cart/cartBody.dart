import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 1 * 2 + 1, //n * 2 + 1 here n is number of itemsCount
        itemBuilder: (context, index) => index.isEven
            ? Divider(
                height: 0,
                thickness: 1,
              )
            : Container(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OnePlus 8T(256GB,12GB)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  "Rs. 35,999",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: 16, color: Colors.black54),
                                ),
                              ],
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
      ),
    );
  }
}
