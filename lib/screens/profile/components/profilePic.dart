import 'dart:io';
import 'package:lorn_sled/screens/profile/components/profile_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

dynamic image;

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: (image == null)
              ? AssetImage(
                  "images/icon3.png",
                )
              : MemoryImage(image),
        ),
        Positioned(
          bottom: 15,
          left: 130,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(120),
              color: Colors.white,
            ),
            child: InkWell(
              onTap: () {
                print("change icon selected");
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.red),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ProfileMenuButton(
                              context: context,
                              svgPath: "icons/Camera Icon.svg",
                              text: 'Camera',
                              fun: () async {
                                final pickedFile = await ImagePicker()
                                    .getImage(source: ImageSource.camera);
                                if (pickedFile != null) {
                                  final bytes =
                                      File(pickedFile.path).readAsBytesSync();
                                  image = bytes;
                                  Toast.show("Profile Pic Updated", context);
                                } else {
                                  print('No image selected.');
                                  Toast.show("No image selected", context);
                                }
                                setState(() {});
                                Navigator.pop(context);
                              }),
                          ProfileMenuButton(
                            context: context,
                            svgPath: "icons/gallary.svg",
                            text: 'Gallery',
                            fun: () async {
                              final pickedFile = await ImagePicker()
                                  .getImage(source: ImageSource.gallery);
                              if (pickedFile != null) {
                                final bytes =
                                    File(pickedFile.path).readAsBytesSync();
                                image = bytes;
                                Toast.show("Profile Pic Updated", context);
                              } else {
                                print('No image selected.');
                                Toast.show("No image selected", context);
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: SvgPicture.asset(
                "icons/Camera Icon.svg",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
