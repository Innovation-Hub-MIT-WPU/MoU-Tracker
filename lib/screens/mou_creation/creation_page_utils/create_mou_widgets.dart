import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/screens/mou_creation/mou_creation_page.dart';
import '/services/Firebase/firestore/upload_service.dart';
import 'package:flutter/material.dart';

DataBaseService db = DataBaseService();

Widget appbar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: const Color(0xFF2D376E),
    title: const Padding(
      padding: EdgeInsets.only(
        top: 35,
      ),
      child: Center(
        child: Text(
          'CREATE MOU',
          style: TextStyle(
              fontSize: 29, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget fileName() {
  return Center(
    child: Text(CreateFormState.file == null
        ? "no file selected"
        : CreateFormState.file!.path.split('/').last),
  );
}

Widget chooseFileButton(BuildContext context, Future Function() pickFile) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      // height: 60,
      // width: 300,
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: ElevatedButton(
        onPressed: () {
          pickFile();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xff64C636)),
          elevation: MaterialStateProperty.all(5),
        ),
        child: const Text(
          'Choose File',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}

Widget dialog(BuildContext cnt) {
  return SimpleDialog(
    backgroundColor: const Color(0xFF2D376E),
    title: Row(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: Icon(
            Icons.error,
            // color: Color(0xFFF2C32C),
            color: kCardRed,
          ),
        ),
        Flexible(
          child: Text(
            "Please Wait",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        )
      ],
    ),
    contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
    children: <Widget>[
      CreateFormState.task != null
          ? buildUploadStatus(CreateFormState.task!)
          : const Text(
              "You haven't selected any file",
              style: TextStyle(color: Colors.white),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    // MaterialStateProperty.all(const Color(0xFFF2C32C))),
                    MaterialStateProperty.all(kCardRed)),
            onPressed: () {
              // CreationDetails.mapping(FirebaseApi.downloadUrl, "downloadLink");
              // CreationDetails.addData();

              Navigator.pop(cnt);
              Navigator.of(cnt).pushReplacementNamed('/submitted');
            },
            child: const Text(
              "Next",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      )
    ],
  );
}

Widget doneButton(BuildContext context, formKey) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      // height: 50,
      // width: 200,
      height: MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) {
            return;
          }
          formKey.currentState!.save();
          FirebaseApi.fileUpload();
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return dialog(context);
              });
          // print(name);
          // print(description);
          // print(id);
          // db.updateMouData(name, description, id, false);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            elevation: MaterialStateProperty.all(0),
            side: MaterialStateProperty.all(
                const BorderSide(color: Colors.black, width: 2))),
        child: const Text(
          'DONE',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    ),
  );
}
