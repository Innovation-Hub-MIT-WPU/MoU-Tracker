import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/fields.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:MouTracker/services/Firebase/firestore/upload_service.dart';
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
  int currStep = 0;
  // for identification and validation of the form

  // page 1
  TextEditingController docNameController = TextEditingController();
  TextEditingController authNameController = TextEditingController();
  TextEditingController spocController = TextEditingController();

  // page 2
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyWebController = TextEditingController();

  //page 3
  TextEditingController descController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
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
      appBar: appBar("CREATE MOU", context),
      body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Form(
            key: _formKey,
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currStep,
              onStepTapped: (index) => setState(() => currStep = index),
              onStepContinue: () => setState(() {
                bool notLastStep = currStep != getSteps().length - 1;
                if (notLastStep) {
                  currStep++;
                } else {
                  submitMOU();
                }
              }),
              onStepCancel: (() => setState(() {
                    if (currStep != 0) {
                      currStep--;
                    }
                  })),
              controlsBuilder: ((context, details) {
                return formButtons(details, getSteps);
              }),
            ),
          )),
    ));
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text("Document"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Document name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Document name",
                  textInputType: TextInputType.text,
                  textEditingController: docNameController),
              const Text(
                "Initator name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Initiator name",
                  textInputType: TextInputType.text,
                  textEditingController: authNameController),
              const Text(
                "SPOC name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "SPOC name",
                  textInputType: TextInputType.text,
                  textEditingController: spocController),
            ],
          ),
        ),
        isActive: currStep >= 0,
        state: currStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Company"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Company name",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Company name",
                  textInputType: TextInputType.text,
                  textEditingController: companyNameController),
              const Text(
                "Company website",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Company website",
                  textInputType: TextInputType.text,
                  textEditingController: companyWebController),
            ],
          ),
        ),
        isActive: currStep >= 1,
        state: currStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Complete"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Due date",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Due date",
                  textInputType: TextInputType.datetime,
                  textEditingController: dueDateController),
              const Text(
                "MOU description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "MOU description",
                  textInputType: TextInputType.text,
                  textEditingController: descController),
              fileName(),
              chooseFileButton(context, pickFile),
            ],
          ),
        ),
        isActive: currStep >= 2,
        state: currStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  void submitMOU() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      // document details
      String docName = docNameController.text;
      String authName = authNameController.text;
      String spocName = spocController.text;

      // company details
      String companyName = companyNameController.text;
      String companyWebsite = companyWebController.text;

      // tracking details
      // DateTime dueDate = dueDateController.text;
      String desc = descController.text;
      DateTime dueDate = DateTime(2022, 03, 02);
      DataBaseService db = DataBaseService();
      NotificationService ns = NotificationService();
      late String mouId;
      db.createMou(
        approved: 0,
        desc: desc,
        authName: authName,
        spocName: spocName,
        docName: docName,
        companyName: companyName,
        companyWebsite: companyWebsite,
        dueDate: dueDate,
        isApproved: false,
      );
      // If text field uploading is successful, Move to File uploading
      FirebaseApi.fileUpload(docName);
      db.addNotification(
          body: "$docName was created by $spocName",
          title: "Mou Created!!",
          doc_name: docName,
          by: spocName,
          on: DateTime.now());
      ns.sendPushMessage(
          "$docName was created by $spocName", "Mou Created!!", docName);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog(context);
          });
    } catch (err) {
      print("Error occurred - $err");
    }
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
    descController.dispose();
    docNameController.dispose();
    companyNameController.dispose();
    authNameController.dispose();
    companyWebController.dispose();
    dueDateController.dispose();
    super.dispose();
  }
}
