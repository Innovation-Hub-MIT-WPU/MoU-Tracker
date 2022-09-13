import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/fields.dart';
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
  TextEditingController descController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TextEditingController docNameController = TextEditingController();
  TextEditingController authNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyWebController = TextEditingController();
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
        ),
      ),
    ));
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text("Document"),
        content: Column(
          children: [
            CreateMouField(
                hintText: "Document name",
                textInputType: TextInputType.text,
                textEditingController: docNameController),
            CreateMouField(
                hintText: "Initiator name",
                textInputType: TextInputType.text,
                textEditingController: authNameController),
          ],
        ),
        isActive: currStep >= 0,
        state: currStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Company"),
        content: Column(
          children: [
            CreateMouField(
                hintText: "Company name",
                textInputType: TextInputType.text,
                textEditingController: companyNameController),
            CreateMouField(
                hintText: "Company website",
                textInputType: TextInputType.text,
                textEditingController: companyWebController),
          ],
        ),
        isActive: currStep >= 1,
        state: currStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text("Complete"),
        content: Column(
          children: [
            CreateMouField(
                hintText: "Due date",
                textInputType: TextInputType.datetime,
                textEditingController: dueDateController),
            CreateMouField(
                hintText: "MOU description",
                textInputType: TextInputType.text,
                textEditingController: descController),
            chooseFileButton(context, pickFile),
          ],
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
      String desc = descController.text;
      String docName = docNameController.text;
      String companyName = companyNameController.text;
      DataBaseService db = DataBaseService();
      await db.updateMouData(
          approved: 0,
          desc: desc,
          docName: docName,
          companyName: companyName,
          isApproved: false);

      // If text field uploading is successful, Move to File uploading
      FirebaseApi.fileUpload();
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
