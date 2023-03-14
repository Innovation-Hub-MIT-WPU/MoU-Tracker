// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, unnecessary_cast

import 'dart:io';

import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/globals.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../../common_utils/drop_down.dart';
import '../../new_nav_bar.dart';

class ProfileTab extends StatefulWidget {
  final PersistentTabController controller;
  const ProfileTab({Key? key, required this.controller}) : super(key: key);

  @override
  State<ProfileTab> createState() => ProfileTabState();
}

class ProfileTabState extends State<ProfileTab> {
  var imageFile;
  String name = "";
  String position = "";
  String email = "";
  String positionNum = "";
  List<String> positionsList = [];
  static final ImagePicker picker = ImagePicker();
  // static late TextEditingController _nameController;
  static late TextEditingController designationController;
  static var myKey = GlobalKey<FormState>();
  String imageUrl = "";
  Future<UserModel> getUserData = DataBaseService().getuserData();
  String user = FireAuth().getCurrentUser()!.uid;
  @override
  void initState() {
    super.initState();
    // _nameController = TextEditingController();
    designationController = TextEditingController();
  }

  @override
  void dispose() {
    // _nameController.dispose();
    designationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getUserData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          UserModel userData = snapshot.data as UserModel;
          name = "${userData.firstName} ${userData.lastName}";
          position = userData.designation!;
          email = userData.email!;
          imageUrl = userData.profileImage!;
          positionNum = userData.pos.toString();
          positionsList = [];
          for (String position in userData.positions!) {
            positionsList.add(position);
          }
          return profilePage();
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Error"),
              Text("${snapshot.error}"),
              TextButton(
                  //need to connect
                  onPressed: () async {
                    FireAuth().logOut();
                    Navigator.of(context, rootNavigator: true)
                        .popAndPushNamed('/login_signup');
                  },
                  child: PText(
                    "LOGOUT",
                    style: GoogleFonts.figtree(),
                  )),
            ],
          );
        } else {
          return Loading();
        }
      }),
    );
  }

  Widget profilePage() {
    return Scaffold(
      appBar: appBar("Profile", context),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.08, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                profile_image(
                    DEFAULT_PROFILE_PICTURE, MediaQuery.of(context).size.width),
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
                          // ignore: unused_local_variable
                          final Name = await openDialog();
                          // if (Name != null || Name!.isNotEmpty) {
                          //   setState(() {
                          //     name = Name;
                          //   });
                          // }
                        },
                        icon: Icon(Icons.edit),
                        label: PText(
                          "Change Designation",
                          style: GoogleFonts.figtree(),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.07, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0XFFCD364E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        //need to connect
                        onPressed: () async {
                          FireAuth().logOut();
                          NotificationService().deteleToken(positionNum);
                          Navigator.of(context, rootNavigator: true)
                              .popAndPushNamed('/login_signup');
                        },
                        child: PText(
                          "LOGOUT",
                          style: GoogleFonts.figtree(),
                        )),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/report_issues');
                  },
                  icon: Icon(Icons.bug_report),
                  label: PText(
                    "Report Isuues",
                    style: GoogleFonts.figtree(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack profile_image(String image_url, double width) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        imageFile == null && imageUrl == "abc"
            ? ProfilePicture(
                name: name,
                // role: position,
                radius: 80,
                fontsize: 28,
                tooltip: true,
                // img: imageUrl,
                // img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
              )
            : imageUrl != "abc"
                ? ProfilePicture(
                    name: name,
                    // role: position,
                    radius: 80,
                    fontsize: 28,
                    tooltip: true,
                    img: imageUrl,
                    // img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
                  )
                : 
                // Shimmer.fromColors(
                //     baseColor: Colors.grey[300]!,
                //     highlightColor: Colors.grey[100]!,
                //     child: CircleAvatar(
                //       radius: 80,
                //       backgroundColor: Colors.grey,
                //     ),
                //   ),
                CircleAvatar(
                    //keep updating the image in firebase database
                    backgroundImage:
                        FileImage(File(imageFile.path)) as ImageProvider,
                    radius: 90,
                  ),
        ClipOval(
          child: Container(
            padding: EdgeInsets.all(width * 0.01),
            color: Colors.white,
            child: CircleAvatar(
              backgroundColor: hexStringToColor("FDC743"),
              radius: width * 0.05,
            ),
          ),
        ),
        Positioned(
          right: width * 0.002,
          bottom: width * 0.002,
          child: IconButton(
            onPressed: () {
              bottomSheet();
            },
            icon: Icon(
              Icons.camera_alt_outlined,
              size: width * 0.05,
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
            style: GoogleFonts.figtree(),
          ),
          SizedBox(width: 10),
          Expanded(
            child: PText(
              text,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.figtree(fontSize: 18, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: PText("Select new Designation"),
          content: Form(
            key: myKey,
            child:
                // TextFormField(
                //   controller: _nameController,
                //   decoration: InputDecoration(hintText: "Enter your name"),
                //   validator: (value) {
                //     if (value!.isEmpty ||
                //         value.contains(RegExp(r'[A-Z]', caseSensitive: false)) ==
                //             false) {
                //       return "Please enter a valid name";
                //     }
                //     return null;
                //   },
                // ),

                Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              height: MediaQuery.of(context).size.height * 0.4,
              child: FormAndDropDown(
                positionsList: positionsList,
                dropDownController: designationController,
                dropDownItem: position,
                screenHeight: MediaQuery.of(context).size.height * 0.5,
                screenWidth: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (myKey.currentState?.validate() == true) {
                  if (await checkPos(user)) {
                    NotificationService().deteleToken(positionNum);
                    DataBaseService().updateDesignation(
                        userId: user,
                        pos: designations.indexOf(designationController.text));

                    Fluttertoast.showToast(msg: "designation changed");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => NewHomePage()));
                  } else {
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(
                        msg: "something went wrong try again later!");
                  }
                }
              },
              child: PText("Done"),
            )
          ],
        ),
      );

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                PText(
                  "Choose Profile Photo",
                  style: GoogleFonts.figtree(fontSize: 20),
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
    try {
      final refer = FirebaseStorage.instance.ref("Profile/$name");
      refer.putFile(File(pickedFile!.path));
      final url = await refer.getDownloadURL();
      User? user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .update({"profile-picture": url});
      setState(() {
        imageFile = pickedFile;
        imageUrl = url;
      });
    // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      // print(e);
    }
  }

  Future<bool> checkPos(String uid) async {
    bool check = false;
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    var snap = await users.doc(uid).get();
    try {
      UserModel getUserData = UserModel.fromMap(snap);
      List positions = getUserData.positions!;
      check = positions.contains(designationController.text.trim());
      // print("check ${getUserData.positions}");
    } catch (e) {
      Fluttertoast.showToast(msg: "database error");
    }

    return check;
  }
}
