import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final product = FirebaseFirestore.instance.collection('products');
  Future<void> addProductTODataBase(String name, int cost, int mrp,
      List<String> description, List imageByteCode) async {
    return await FirebaseFirestore.instance
        .collection('products')
        .doc(name)
        .set({
      "name": name,
      "cost": cost,
      "mrp": mrp,
      "description": description.toString(),
      "image": imageByteCode.toString(),
    });
  }
}
