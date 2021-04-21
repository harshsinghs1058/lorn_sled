import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:lorn_sled/screens/createAccount/createAccount.dart';
import 'package:lorn_sled/screens/log%20in/login_page.dart';
import 'package:lorn_sled/services/auth.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

String _email = "";

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(250, 250, 250, 250),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            }),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "images/fp1.png",
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Reset Password",
              style: TextStyle(fontSize: 28),
            ),
            Spacer(),
            TextInputForm(
              s: "Email",
              keyBoard: TextInputType.emailAddress,
              onChange: (value) {
                _email = value;
              },
              color: Colors.black,
              autofocus: true,
              validator: (value) {
                _email = _email.trim();
                print(_email);
                if (EmailValidator.validate(_email)) {
                  return null;
                } else
                  return "Enter a valid mail";
              },
            ),
            Spacer(),
            ButtonTemp(
              s: "Get link",
              h: 50,
              c: Colors.blue,
              fun: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result = await Auth().sendOtp(_email);
                  if (result == null) {
                    // await infoDialog(
                    //     context, "Check mail for password reset link");
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.SUCCES,
                        title: "Sucess",
                        desc: "Check mail for password reset link",
                        btnOkText: "Ok",
                        btnOkOnPress: () {
                          print("Navigating to LogIn page");
                        },
                        onDissmissCallback: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()));
                        })
                      ..show();
                  } else {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        title: "Error",
                        desc: "Email-Id is not registered\nPlease sign-up",
                        btnOkText: "Ok",
                        btnOkOnPress: () {
                          print("Navigating to create account page");
                        },
                        onDissmissCallback: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccount(),
                            ),
                          );
                        })
                      ..show();
                  }
                }
              },
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTemp extends StatelessWidget {
  const ButtonTemp({Key key, this.s, this.h, this.c, this.fun, this.fontColor})
      : super(key: key);

  final String s;
  final double h;
  final Color c;
  final Function fun;
  final Color fontColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        fun();
      },
      style: ElevatedButton.styleFrom(
        onPrimary: c,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // color: c,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: h, vertical: 10),
        child: Text(
          s,
          style: TextStyle(fontSize: 28, color: fontColor ?? Colors.white),
        ),
      ),
    );
  }
}

class TextInputForm extends StatelessWidget {
  final String s;
  final onChange;
  final validator;
  final obscureText;
  final color;
  final keyBoard;
  final autofocus;
  final textInputAction;

  TextInputForm({
    this.s,
    this.onChange,
    this.validator,
    this.obscureText,
    this.color,
    this.keyBoard,
    this.autofocus,
    this.textInputAction,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
      child: TextFormField(
        style: TextStyle(color: color ?? Colors.white),
        keyboardType: keyBoard ?? TextInputType.text,
        validator: (value) {
          if (validator != null) {
            return validator(value);
          } else
            return null;
        },
        autofocus: autofocus ?? false,
        obscureText: obscureText ?? false,
        textInputAction: textInputAction ?? TextInputAction.next,
        decoration: InputDecoration(
          labelText: s,
          labelStyle: TextStyle(color: color ?? Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.greenAccent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
