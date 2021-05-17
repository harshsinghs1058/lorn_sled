import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final product = FirebaseFirestore.instance.collection('products');
  final user = FirebaseFirestore.instance.collection('user');
  Future<void> addProductTODataBase(String name, int cost, int mrp,
      List<String> descriptionList, List imageByteCode, int count) async {
    String image = json.encode(imageByteCode);
    String description = json.encode(descriptionList);

    return await FirebaseFirestore.instance
        .collection('products')
        .doc(name)
        .set({
      "name": name,
      "cost": cost,
      "mrp": mrp,
      "description": description,
      "image": image,
      "ratingCount": 0,
      "count": count,
      "rating": "null"
    });
  }

  Future<void> newUserInitlise(String uid, String mail) async {
    String name = (mail.split("@"))[0];
    await user.doc(uid).set(
      {
        "uid": uid,
        "name": name,
        "mail": mail,
        "mobileNumber": "null",
        "ordreCount": 0,
        "orders": "null",
        "delivered": "null",
        "deliveredCount": 0,
        "address": "null",
        "image": "null",
        "WishList": "null",
        "WishListCount": "null",
      },
    );
    print("NEW USER DATABASE INITILIZED");
  }
}
