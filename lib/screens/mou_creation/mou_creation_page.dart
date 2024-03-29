import 'package:MouTracker/common_utils/upload_file.dart';
import 'package:MouTracker/common_widgets/widgets.dart';
import 'package:MouTracker/screens/mou_creation/creation_page_utils/create_mou_widgets.dart';
import 'package:MouTracker/common_widgets/fields.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:MouTracker/services/Firebase/fcm/notification_service.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:MouTracker/services/Firebase/firestore/upload_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:google_fonts/google_fonts.dart';

import '../../services/Firebase/fireauth/model.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({Key? key}) : super(key: key);

  @override
  State<CreateForm> createState() => CreateFormState();
}

class CreateFormState extends State<CreateForm> {
  int currStep = 0;
  DateTime selectedDate = DateTime.now();
  // for identification and validation of the form

  // page 1
  TextEditingController docNameController = TextEditingController();
  TextEditingController tenureController = TextEditingController();

  TextEditingController descController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();

  // page 2
  TextEditingController companyNameController = TextEditingController();
  TextEditingController domainController = TextEditingController();
  TextEditingController employeeController = TextEditingController();
  TextEditingController turnoverController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyWebController = TextEditingController();

  //page 3
  late String initiatorName;
  late String initiatorDesignation;
  TextEditingController authNameController = TextEditingController();
  TextEditingController initiatorDesignationController =
      TextEditingController();

  TextEditingController spocNameController = TextEditingController();
  TextEditingController spocNoController = TextEditingController();
  TextEditingController spocDesignationController = TextEditingController();

  static io.File? file;
  static UploadTask? task;
  final _formKey = GlobalKey<FormState>();
  late UserModel userData;

  Future<UserModel> getUserData = DataBaseService().getuserData();
  @override
  void initState() {
    file = null;
    task = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
              steps: getSteps(h, w),
              currentStep: currStep,
              onStepTapped: (index) => setState(() => currStep = index),
              onStepContinue: () => setState(() {
                bool notLastStep = currStep != getSteps(h, w).length - 1;
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
                return formButtons(h, w, details, getSteps);
              }),
            ),
          )),
    ));
  }

  List<Step> getSteps(double h, double w) {
    return [
      Step(
        title: PText(
          "Document",
          style: GoogleFonts.figtree(
              fontSize: w * 0.035, fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.025),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText(
                "Document name",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Document name",
                  textInputType: TextInputType.multiline,
                  textEditingController: docNameController),
              PText(
                "MOU description",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "MOU description",
                  textInputType: TextInputType.text,
                  textEditingController: descController),
              PText(
                "Tenure",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Tenure",
                  textInputType: TextInputType.text,
                  textEditingController: tenureController),
              PText(
                // "Due Date",
                //     ? "Due date : ${selectedDate.month}-${selectedDate.day}-${selectedDate.year}"
                //     :
                "Due date : ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  // width: MediaQuery.of(context).size.width * 1.5,
                  decoration: BoxDecoration(
                      color: const Color(0XFFEFF3F6),
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            offset: Offset(6, 3),
                            blurRadius: 4.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                            color: Color.fromRGBO(255, 255, 255, 0.9),
                            offset: Offset(-6, -3),
                            blurRadius: 4.0,
                            spreadRadius: 1.0)
                      ]),
                  child: CupertinoDatePicker(
                    dateOrder: DatePickerDateOrder.dmy,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newDateTime) {
                      setState(() {
                        selectedDate = newDateTime;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isActive: currStep >= 0,
        state: currStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: PText(
          "Company",
          style: GoogleFonts.figtree(
              fontSize: w * 0.035, fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.025),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PText(
                "Full Organization Name",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Company name",
                  textInputType: TextInputType.text,
                  textEditingController: companyNameController),
              PText(
                "Industry Domain",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Segment/Domain/Vertical/Technology",
                  textInputType: TextInputType.text,
                  textEditingController: domainController),
              PText(
                "Annual Turnover",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "In Lakhs INR",
                  textInputType: TextInputType.number,
                  textEditingController: turnoverController),
              PText(
                "No. of Employees",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "No. of Employees",
                  textInputType: TextInputType.number,
                  textEditingController: employeeController),
              PText(
                "Address",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Co-oporate location",
                  textInputType: TextInputType.text,
                  textEditingController: addressController),
              PText(
                "Company website",
                style: GoogleFonts.figtree(
                    fontSize: w * 0.040, fontWeight: FontWeight.bold),
              ),
              CreateMouField(
                  hintText: "Company website",
                  textInputType: TextInputType.url,
                  textEditingController: companyWebController),
            ],
          ),
        ),
        isActive: currStep >= 1,
        state: currStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: PText(
          "Complete",
          style: GoogleFonts.figtree(
              fontSize: w * 0.035, fontWeight: FontWeight.bold),
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.025),
          child: FutureBuilder(
              future: getUserData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  userData = snapshot.data as UserModel;
                  initiatorName = "${userData.firstName} ${userData.lastName}";
                  initiatorDesignation = userData.designation.toString();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText(
                        "Initiated By",
                        style: GoogleFonts.figtree(
                            fontSize: w * 0.040, fontWeight: FontWeight.bold),
                      ),
                      nonEditable(w, initiatorName),
                      PText(
                        "Initiator Designation",
                        style: GoogleFonts.figtree(
                            fontSize: w * 0.040, fontWeight: FontWeight.bold),
                      ),
                      nonEditable(w, initiatorDesignation),
                      PText(
                        "SPOC Name",
                        style: GoogleFonts.figtree(
                            fontSize: w * 0.040, fontWeight: FontWeight.bold),
                      ),
                      CreateMouField(
                          hintText: "SPOC's Name",
                          textInputType: TextInputType.text,
                          textEditingController: spocNameController),
                      PText(
                        "SPOC Designation",
                        style: GoogleFonts.figtree(
                            fontSize: w * 0.040, fontWeight: FontWeight.bold),
                      ),
                      CreateMouField(
                          hintText: "Designation",
                          textInputType: TextInputType.text,
                          textEditingController: spocDesignationController),
                      PText(
                        "SPOC Contact",
                        style: GoogleFonts.figtree(
                            fontSize: w * 0.040, fontWeight: FontWeight.bold),
                      ),
                      CreateMouField(
                          hintText: "SPOC's mobile no.",
                          textInputType: TextInputType.phone,
                          textEditingController: spocNoController),
                      fileName(file),
                      chooseFileButton(context, pickFile),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
        isActive: currStep >= 2,
        state: currStep > 2 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  Widget nonEditable(double w, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: w * 0.035),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.065,
          width: MediaQuery.of(context).size.width * 1.5,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.black38),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    offset: Offset(6, 3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0),
                BoxShadow(
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                    offset: Offset(-6, -3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0)
              ]),
          child: Container(
              padding: EdgeInsets.only(left: w * 0.025, top: w * 0.045),
              child: PText(
                hintText,
                style: GoogleFonts.figtree(fontSize: w * 0.04),
              ))),
    );
  }

  void submitMOU() async {
    if (!_formKey.currentState!.validate() || file == null) {
      if (file == null) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return dialog(context, file, '/submitted');
            });
      }
      return;
    }
    _formKey.currentState!.save();
    try {
      // MOU details
      String docName = docNameController.text;
      String tenure = tenureController.text;

      // SPOC Details
      String spocName = spocNameController.text;
      String spocNo = spocNoController.text;
      String spocDesignation = spocDesignationController.text;

      // Company details
      String companyName = companyNameController.text;
      String companyWebsite = companyWebController.text;
      String companyTurnOver = turnoverController.text;
      String companyAddress = addressController.text;
      String companyEmployees = employeeController.text;
      String companyDomain = domainController.text;

      // Tracking details
      String desc = descController.text;
      DateTime dueDate = selectedDate;

      DataBaseService db = DataBaseService();
      NotificationService ns = NotificationService();
      final mouId = await db.createMou(
        approved: 0,
        authName: initiatorName,
        authDesignation: initiatorDesignation,
        docName: docName,
        tenure: tenure,
        spocName: spocName,
        spocNo: spocNo,
        spocDesignation: spocDesignation,
        companyName: companyName,
        companyTurnOver: companyTurnOver,
        companyAddress: companyAddress,
        companyEmployees: companyEmployees,
        companyDomain: companyDomain,
        companyWebsite: companyWebsite,
        desc: desc,
        dueDate: dueDate,
        isApproved: false,
      );
      // If text field uploading is successful, Move to File uploading
      FirebaseApi.fileUpload(mouId, file);
      db.addNotification(
          mouId: mouId.toString(),
          body: "$docName was created by $initiatorName",
          title: "Mou Created!!",
          doc_name: docName,
          by: spocName,
          due: dueDate,
          on: DateTime.now());
      ns.sendPushMessage("$docName was created by $initiatorName",
          "Mou Created!!", mouId.toString(), 6);
      await DataBaseService().addDataToStats("total_initiated",
          DateTime.now().year.toString(), DateTime.now().month);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return dialog(context, file, '/submitted');
          });
    } catch (err) {
      // print("Error occurred - $err");
    }
  }

  Future pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      // print("result null");
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
