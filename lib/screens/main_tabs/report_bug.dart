// ignore_for_file: prefer_const_constructors, sort_child_properties_last, deprecated_member_use

import 'package:MouTracker/common_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:MouTracker/screens/main_tabs/profile_tab.dart';

class reportIssues extends StatefulWidget {
  const reportIssues({Key? key}) : super(key: key);

  @override
  State<reportIssues> createState() => _reportIssuesState();
}

class _reportIssuesState extends State<reportIssues> {
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
        backgroundColor: hexStringToColor("2D376E"),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                "Report Issues",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: Theme.of(context).textTheme.headline2!.fontFamily,
                  fontSize: Theme.of(context).textTheme.headline3!.fontSize,
                ),
              ),
            ),
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.1)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              children: [
                textBox("Name", ProfileTabState.name),
                SizedBox(
                  height: 30,
                ),
                textBox("Position", ProfileTabState.position),
                SizedBox(
                  height: 30,
                ),
                textBox("Email", ProfileTabState.email),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: reportKey,
                  child: TextFormField(
                    controller: _issueController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pls enter your issue";
                      }
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
                  child: FlatButton(
                      onPressed: () {
                        if (reportKey.currentState?.validate() == true) {
                          issue = _issueController.text;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Issue Submitted"),
                            duration: Duration(seconds: 2),
                          ));
                          _issueController.clear();
                        }
                      },
                      child: Text(
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
