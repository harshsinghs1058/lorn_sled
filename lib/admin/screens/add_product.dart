import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:lorn_sled/services/database.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

List<TextEditingController> _productDescription = [];
List<TextEditingController> _productImage = [];
int _productDescriptionCount = 0;
int _productImageCount = 0;
String error = "error";

class _AddProductState extends State<AddProduct> {
  final _productMRP = TextEditingController();
  final _productCost = TextEditingController();
  final _productName = TextEditingController();
  final _productCount = TextEditingController();
  final _formState = GlobalKey<FormState>();
  final myController = TextEditingController();
  final picker = ImagePicker();
  // getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final bytes = File(pickedFile.path).readAsBytesSync();
  //     _productImage.add(bytes);
  //   } else {
  //     print('No image selected.');
  //     Toast.show("No image selected", context);
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Add New Item",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {}),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  buildTextFormField(
                      _productName, " Item Name", TextInputType.name),
                  buildTextFormField(
                      _productCost, " Selling price", TextInputType.number),
                  buildTextFormField(
                      _productMRP, " Product MRP", TextInputType.number),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        TextEditingController temp = TextEditingController();
                        _productImage.add(temp);
                        _productImageCount++;
                      });
                    },
                    child: Text(
                      "Add image",
                    ),
                  ),
                  _buildImage(),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      " Description : ",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 22,
                          ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        TextEditingController temp = TextEditingController();
                        _productDescription.add(temp);
                        _productDescriptionCount++;
                      });
                    },
                    child: Text(
                      "Add point",
                    ),
                  ),
                  _buildDescription(),
                  ElevatedButton(
                    onPressed: () {
                      if (_formState.currentState.validate()) {
                        if (_productDescription.length > 0 &&
                            _productImage.length > 0) {
                          if (int.parse(_productCost.text) <=
                              int.parse(_productMRP.text)) {
                            print("product name : " + _productName.text);
                            print("product cost : " + _productCost.text);
                            print("product MRP : " + _productMRP.text);
                            List<String> _productDescriptionText = [];
                            for (int i = 0;
                                i < _productDescription.length;
                                i++) {
                              _productDescriptionText
                                  .add(_productDescription[i].text);
                            }
                            List<String> _productImageText = [];
                            for (int i = 0; i < _productImage.length; i++) {
                              _productImageText.add(_productImage[i].text);
                            }
                            print("product Desciption : " +
                                _productDescriptionText.toString());
                            print("product Image : " +
                                _productImageText.toString());
                            DataBase().addProductTODataBase(
                              _productName.text,
                              int.parse(_productCost.text),
                              int.parse(_productMRP.text),
                              _productDescriptionText,
                              _productImageText,
                              int.parse(_productCount.text),
                            );
                          } else {
                            Toast.show("MRP can't be less than cost", context);
                          }
                        } else {
                          if (_productDescription.length == 0 &&
                              _productImage.length == 0) {
                            Toast.show("Description and  images cant be empty",
                                context);
                          } else if (_productDescription.length == 0) {
                            Toast.show("Description cant be empty", context);
                          } else if (_productImage.length == 0) {
                            Toast.show("Images cant be empty", context);
                          }
                        }
                      } else {
                        print("not validated");
                      }
                    },
                    child: Text(
                      "Add product to dataBase",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Container _buildimages() {
  //   return Container(
  //     height: getProportionateScreenWidth(350),
  //     child: PageView.builder(
  //       itemCount: _productImage.toString() == "[]" ? 1 : _productImage.length,
  //       itemBuilder: (context, index) {
  //         if (index == 0 && _productImage.toString() == "[]") {
  //           return Container(
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               color: Colors.grey.shade400,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Icon(
  //               Icons.add_a_photo_outlined,
  //               color: Colors.white,
  //               size: 100,
  //             ),
  //           );
  //         } else
  //           return Center(
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Image.memory(_productImage[index]),
  //             ),
  //           );
  //       },
  //     ),
  //   );
  // }

  Widget _buildDescription() {
    List<Widget> _temp = [];
    for (int i = 0; i < _productDescriptionCount; i++) {
      _temp.add(
        buildTextFormField(_productDescription[i],
            " Desciption " + (i + 1).toString(), TextInputType.name),
      );
    }
    return Column(
      children: _temp,
    );
  }

  Widget _buildImage() {
    List<Widget> _temp = [];
    for (int i = 0; i < _productImageCount; i++) {
      _temp.add(
        buildTextFormField(_productImage[i],
            " Image link " + (i + 1).toString(), TextInputType.name),
      );
    }
    return Column(
      children: _temp,
    );
  }

  Theme buildTextFormField(TextEditingController productName, String s,
      TextInputType textInputType) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.amber),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          keyboardType: textInputType,
          controller: productName,
          validator: (String value) {
            if (value.isEmpty) {
              return s + " Can't be empty";
            }
            return null;
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: s,
            hintStyle: TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
