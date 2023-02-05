// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use, use_build_context_synchronously, avoid_print

import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/screens/Loading/loading_spinner.dart';
import 'package:MouTracker/screens/home_page/main_tabs/profile_page/profile_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/common_utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../services/Firebase/fireauth/model.dart';
import '../../../../../services/Firebase/firestore/firestore.dart';

class ReportIssues extends StatefulWidget {
  const ReportIssues({Key? key}) : super(key: key);

  @override
  State<ReportIssues> createState() => _ReportIssuesState();
}

class _ReportIssuesState extends State<ReportIssues> {
  static var reportKey = GlobalKey<FormState>();
  static late TextEditingController _issueController;
  static late String issue;

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

  String name = "";
  String position = "";
  String email = "";
  CollectionReference issues = FirebaseFirestore.instance.collection('issues');
  Future<UserModel> getUserData = DataBaseService().getuserData();

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
          return reportBugPage(context);
        } else {
          return Loading();
        }
      }),
    );
  }

  Scaffold reportBugPage(BuildContext context) {
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
                          issue = _issueController.text;
                          await issues.add({
                            'issue': issue,
                            'name': name,
                            'email': email,
                            'position': position,
                            'time': DateTime.now()
                          }).then((value) => print('Issue Submitted'));
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
