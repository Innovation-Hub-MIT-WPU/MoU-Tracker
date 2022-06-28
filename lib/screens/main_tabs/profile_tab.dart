// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late TextEditingController _nameController;
  String name = "take from the firebase";

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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.15, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "PROFILE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                profile_image("assets/images/logo.png"),
                SizedBox(
                  height: 20,
                ),
                text_display("Name:", name, 28),
                text_display("Position:", "take from the firebase", 10),
                text_display("Email:", "take from the firebase", 34),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                        onPressed: () async {
                          final name = await openDialog();
                          if (name != null || name!.isNotEmpty)
                            this.name = name;
                        },
                        icon: Icon(Icons.edit),
                        label: Text("Edit")),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        "LOGOUT",
                        style: TextStyle(color: hexStringToColor("7E7E7E")),
                      )),
                )
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
          //take image from firebase
          backgroundImage: AssetImage(image_url),
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
            onPressed: () {},
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
        children: [
          Text(
            heading,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            width: width,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Enter your name"),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(_nameController.text),
              child: Text("Done"),
            )
          ],
        ),
      );
}
