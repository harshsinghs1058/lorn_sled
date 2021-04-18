import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lorn_sled/constants/sizeConfigure.dart';
import 'package:lorn_sled/screens/createAccount/backgroundCreateAccount.dart';
import 'package:lorn_sled/screens/log%20in/login_page.dart';
import 'package:lorn_sled/services/auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:lorn_sled/constants/loading.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

String _email = "";
String _password = "";

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Stack(
      children: [
        Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              BackGroundCreateAccountPage(height: height, width: width),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
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
                          style: TextStyle(fontSize: 20),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20,
                      ),
                      child: Theme(
                        data: ThemeData(primarySwatch: Colors.amber),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (String value) {
                            _password = value;
                            if (value.length > 7) {
                              return null;
                            } else {
                              return "Password should of 8 chracters";
                            }
                          },
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20,
                      ),
                      child: Theme(
                        data: ThemeData(primarySwatch: Colors.amber),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String value) {
                            print("ma pagal hu");
                            if (_password == value) {
                              return null;
                            } else {
                              return "Confirm password doesnot match.";
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "  Confirm Password",
                            hintStyle: TextStyle(color: Colors.black),
                            suffixIcon: Icon(
                              FlutterIcons.check_all_mco,
                            ),
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                      dynamic result = await Auth().signUp(_email, _password);
                      print(result.toString());
                      if (Navigator.canPop(context)) Navigator.pop(context);
                      if (result == null) {
                        print("Account created sussesfully");
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            title: "Sucess",
                            desc: "Account created sussesfully",
                            btnOkText: "Sign in",
                            btnOkOnPress: () {
                              print("Navigating to log in page");
                            },
                            onDissmissCallback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInPage()));
                            })
                          ..show();
                      } else if (result.code.toString() ==
                          "email-already-in-use") {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.INFO,
                            title: "Already In Use",
                            desc: "Email Id is already in use",
                            btnOkText: "Sign in",
                            btnOkOnPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInPage()));
                            },
                            btnCancelOnPress: () {})
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
}
