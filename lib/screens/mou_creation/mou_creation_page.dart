import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/fields.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  // for identification and validation of the form

  TextEditingController idController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController docNameController = TextEditingController();
  TextEditingController authNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  static io.File? file;
  static UploadTask? task;
  final _formKey = GlobalKey<FormState>();
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
      backgroundColor: const Color(0XFFEFF3F6),
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
                    CreateMouField(
                        hintText: 'Document Name',
                        textInputType: TextInputType.text,
                        textEditingController: docNameController),
                    CreateMouField(
                        hintText: 'Company Name',
                        textInputType: TextInputType.text,
                        textEditingController: companyNameController),
                    CreateMouField(
                        hintText: 'Description',
                        textInputType: TextInputType.text,
                        textEditingController: descController),
                    CreateMouField(
                        hintText: 'MOU Id',
                        textInputType: TextInputType.text,
                        textEditingController: idController),
                    fileName(),
                    chooseFileButton(context, pickFile),
                    doneButton(
                      context: context,
                      formKey: _formKey,
                      docName: docNameController.text,
                      companyName: companyNameController.text,
                      id: idController.text,
                      desc: descController.text,
                    )
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

  @override
  void dispose() {
    // TODO: implement dispose
    docNameController.dispose();
    companyNameController.dispose();
    idController.dispose();
    descController.dispose();
    super.dispose();
  }
}
