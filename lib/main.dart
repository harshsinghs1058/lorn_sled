import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lorn_sled/screens/home/home_screen.dart';
import 'package:lorn_sled/screens/wrapper/wrapper.dart';
import 'package:lorn_sled/services/auth.dart';

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
      home: (Auth().loadUser() != null) ? HomeScreen() : Wrapper(),
      debugShowCheckedModeBanner: false,
      title: "Lorn Sled",
    );
  }
}
