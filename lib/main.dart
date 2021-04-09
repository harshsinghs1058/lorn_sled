import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lorn_sled/admin/screens/add_product.dart';
import 'package:lorn_sled/screens/cart/cartPage.dart';
import 'package:lorn_sled/screens/createAccount/createAccount.dart';
import 'package:lorn_sled/screens/home%20page/homePage.dart';
import 'package:lorn_sled/screens/itemView/itemView.dart';
import 'package:lorn_sled/screens/log%20in/login_page.dart';
import 'package:lorn_sled/screens/profile/profilePage.dart';
import 'package:lorn_sled/screens/wrapper/wrapper.dart';

var userUid;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      title: "Lorn Sled",
    );
  }
}
