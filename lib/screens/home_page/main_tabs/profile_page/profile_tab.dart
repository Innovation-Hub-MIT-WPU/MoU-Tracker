// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, unnecessary_cast

import 'dart:io';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/globals.dart';
import 'package:MouTracker/classes/personalized_text.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/get_started/check_logged.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  var imageFile;
  String name = "";
  String position = "";
  String email = "";
  static final ImagePicker picker = ImagePicker();
  static late TextEditingController _nameController;
  static var myKey = GlobalKey<FormState>();
  Future<UserModel> getUserData = DataBaseService().getuserData();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data as UserModel;
          name = "${userData.firstName} ${userData.lastName}";
          position = userData.designation!;
          email = userData.email!;
          return profilePage();
        } else {
          return Loading();
        }
      }),
    );
  }

  Widget profilePage() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.08, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PText(
                  "PROFILE",
                  style: Theme.of(context).textTheme.headline3,
                ),
                Container(
                  width: 100,
                  child: Divider(
                    color: hexStringToColor("F2C32C"),
                    thickness: 5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                profile_image(DEFAULT_PROFILE_PICTURE),
                SizedBox(
                  height: 20,
                ),
                text_display("Name:", name, 28),
                text_display("Position:", position, 10),
                text_display("Email:", email, 34),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () async {
                          final Name = await openDialog();
                          if (Name != null || Name!.isNotEmpty) {
                            setState(() {
                              name = Name;
                            });
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: PText("Edit")),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.15, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        //need to connect
                        onPressed: () {
                          FireAuth().logOut();
                          // Navigator.popAndPushNamed(context, '/start');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CheckAuth()));
                        },
                        child: PText(
                          "LOGOUT",
                          style: Theme.of(context).textTheme.button,
                        )),
                  ),
                ),
                TextButton.icon(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/report_issues');
                    },
                    icon: Icon(Icons.bug_report),
                    label: PText("Report Isuues")),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack profile_image(String image_url) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(
          //keep updating the image in firebase database
          backgroundImage: imageFile == null
              ? NetworkImage(image_url)
              : FileImage(File(imageFile.path)) as ImageProvider,
          radius: 90,
        ),
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(3),
            color: Colors.white,
            child: CircleAvatar(
              backgroundColor: hexStringToColor("FDC743"),
              radius: 30,
            ),
          ),
        ),
        Positioned(
          right: 13.5,
          bottom: 12,
          child: IconButton(
            onPressed: () {
              bottomSheet();
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Padding text_display(String heading, String text, double width) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PText(
            heading,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(width: 10),
          Expanded(
            child: PText(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: Theme.of(context).textTheme.headline3?.fontFamily,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: PText("Enter your name"),
          content: Form(
            key: myKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Enter your name"),
              validator: (value) {
                if (value!.isEmpty ||
                    value.contains(RegExp(r'[A-Z]', caseSensitive: false)) ==
                        false) {
                  return "Please enter a valid name";
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (myKey.currentState?.validate() == true)
                  Navigator.of(context).pop(_nameController.text);
              },
              child: PText("Done"),
            )
          ],
        ),
      );

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                PText(
                  "Choose Profile Photo",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        takePhoto(ImageSource.camera);
                      },
                      icon: Icon(Icons.camera),
                      label: PText("Camera"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        takePhoto(ImageSource.gallery);
                      },
                      icon: Icon(Icons.image),
                      label: PText("Gallery"),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageFile = pickedFile;
    });
  }
}
