import 'package:file_picker/file_picker.dart';

import 'creation_page_utils/create_mou_widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'creation_page_utils/fields.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  // for identification and validation of the form
  final _formKey = GlobalKey<FormState>();
  static UploadTask? task;
  static io.File? file;
  static String field1 = '';
  static String field2 = '';
  static String field3 = '';
  static String field4 = '';
  static String field5 = '';
  static String field6 = '';
  @override
  void initState() {
    file = null;
    task = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0XFFEFF3F6),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 8,
        backgroundColor: const Color(0xff2D376E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'CREATE MOU',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildField1(),
                    buildField2(),
                    buildField3(),
                    buildField4(),
                    buildField5(),
                    buildField6(),
                    fileName(),
                    chooseFileButton(context, pickFile),
                    doneButton(context, _formKey)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      print("result null");
      return;
    } else {
      final filepath = result.files.single.path!;
      setState(() {
        file = io.File(filepath);
      });
    }
  }
}
