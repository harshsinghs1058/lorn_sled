import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lorn_sled/constants/loading.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/cart/cartPage.dart';
import 'package:lorn_sled/screens/log%20in/background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lorn_sled/services/auth.dart';

class LogInPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

String _email = "";
String _password = "";

class _State extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BackGroundLogInPage(height: height, width: width),
              Positioned(
                top: height * 0.1,
                child: Text(
                  "  Welcome\n  Back!",
                  style: TextStyle(
                    fontSize: 48,
                    decoration: TextDecoration.none,
                    color: Colors.black,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _emailField(),
                    _passwordField(),
                  ],
                ),
              ),
              Positioned(
                top: height * 0.8,
                left: width * 0.68,
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      print("validated");
                      print("Email : " + _email);
                      print("Password : " + _password);
                      loadingIndicator(context);
                      dynamic result = await Auth().signIn(_email, _password);
                      Navigator.pop(context);
                      if (result == null) {
                        print("Sussesfully Logged In");
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            title: "Sucess",
                            desc: "Sussesfully Logged In",
                            btnOkText: "Ok",
                            btnOkOnPress: () {
                              print("Navigating to home page");
                            },
                            onDissmissCallback: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            })
                          ..show();
                      } else {
                        print(result.code.toString());
                        String error = result.code.toString();
                        error = error.replaceAll("-", " ");
                        print(error);
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.ERROR,
                          title: "Error",
                          desc: error,
                        )..show();
                      }
                    }
                  },
                  child: Container(
                    height: getProportionateScreenHeight(70),
                    width: getProportionateScreenWidth(100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Padding _passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20,
      ),
      child: Theme(
        data: ThemeData(primarySwatch: Colors.amber),
        child: TextFormField(
          obscureText: true,
          validator: (String value) {
            _password = value;

            if (value.length > 7) {
              return null;
            } else {
              return "Password should of 8 chracters";
            }
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: " Password",
            hintStyle: TextStyle(color: Colors.black),
            suffixIcon: Icon(FlutterIcons.key_ent),
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

  Padding _emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20,
      ),
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.amber,
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            value = value.trim();
            _email = value;
            if (EmailValidator.validate(value)) {
              return null;
            } else {
              return "Please enter a valid mail";
            }
          },
          decoration: InputDecoration(
            hintText: " Email",
            hintStyle: TextStyle(color: Colors.black),
            suffixIcon: Icon(
              FlutterIcons.md_person_ion,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                color: Colors.amber,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                50,
              ),
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
