// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../services/Firebase/fireauth/model.dart';

class ReportIssues extends StatefulWidget {
  const ReportIssues({Key? key}) : super(key: key);

  @override
  State<ReportIssues> createState() => _ReportIssuesState();
}

class _ReportIssuesState extends State<ReportIssues> {
  static var reportKey = GlobalKey<FormState>();
  static late TextEditingController _issueController;

  @override
  void initState() {
    super.initState();
    _issueController = TextEditingController();
  }

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        toolbarHeight: MediaQuery.of(context).size.width * 0.24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(MediaQuery.of(context).size.width * 0.05),
          ),
        ),
        backgroundColor: hexStringToColor("2D376E"),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: PText(
                "Report Issues",
                style: GoogleFonts.figtree(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: [
                // textBox("Name", name),
                // SizedBox(
                //   height: 30,
                // ),
                // textBox("Position", position),
                // SizedBox(
                //   height: 30,
                // ),
                // textBox("Email", email),
                // SizedBox(
                //   height: 30,
                // ),0
                Form(
                  key: reportKey,
                  child: TextFormField(
                    controller: _issueController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pls enter your issue";
                      }
                      return null;
                    },
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: "Issue you are facing",
                      labelText: "Issues",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, MediaQuery.of(context).size.height * 0.2, 0, 0),
                  child: TextButton(
                      onPressed: () async {
                        if (reportKey.currentState?.validate() == true) {
                          final CollectionReference users =
                              FirebaseFirestore.instance.collection('users');
                          User? user = FirebaseAuth.instance.currentUser!;
                          var snap = await users.doc(user.uid).get();
                          UserModel getUserData = UserModel.fromMap(snap);

                          bool docExists = await checkIfDocExists(user.uid);

                          (docExists)
                              ? FirebaseFirestore.instance
                                  .collection("issues")
                                  .doc(user.uid)
                                  .update({
                                  'email': getUserData.email,
                                  'position': getUserData.designation,
                                  'name': getUserData.firstName,
                                  'issue': FieldValue.arrayUnion([
                                    _issueController.text,
                                  ]),
                                  'time': DateTime.now().toString(),
                                })
                              : FirebaseFirestore.instance
                                  .collection("issues")
                                  .doc(user.uid)
                                  .set({
                                  'email': getUserData.email,
                                  'position': getUserData.designation,
                                  'name': getUserData.firstName,
                                  'issue': FieldValue.arrayUnion([
                                    _issueController.text,
                                  ]),
                                  'time': DateTime.now().toString(),
                                });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: PText("Issue Submitted"),
                            duration: Duration(seconds: 2),
                          ));
                          _issueController.clear();
                        }
                      },
                      child: PText(
                        "SUBMIT",
                        style: Theme.of(context).textTheme.button,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var collectionRef = FirebaseFirestore.instance.collection('issues');
      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }

  Widget textBox(String labelText, String intialValue) {
    return TextFormField(
      initialValue: intialValue,
      readOnly: true,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
