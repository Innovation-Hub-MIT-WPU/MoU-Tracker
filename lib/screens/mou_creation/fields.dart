import 'package:flutter/material.dart';
import 'package:mou_tracker/screens/create_mou_page/create.dart';

import '../../models/create_mou_backend.dart';
import '../../services/upload_service.dart';

Widget fields(String text, String hintText) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 40,
        width: 400,
        child: TextFormField(
          onChanged: (val) {
            CreationDetails.mapping(val, hintText);
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: hintText,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget title(String text) {
  return Center(
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontSize: 35, fontWeight: FontWeight.w400),
    ),
  );
}

Widget button1(Future Function() pickfile) {
  return FlatButton(
    onPressed: () => pickfile(),
    child: const SizedBox(
      height: 40,
      width: 400,
      child: Center(
        child: Text("Select file"),
      ),
    ),
    autofocus: true,
    color: const Color(0xFF64C636),
  );
}

Widget dialog(BuildContext cnt) {
  return SimpleDialog(
    backgroundColor: const Color(0xFF2D376E),
    // shape: Border(left: BorderSide(width: 2, color: Colors.black)),
    title: Row(
      children: const <Widget>[
        Icon(
          Icons.error,
          color: Color(0xFFF2C32C),
        ),
        SizedBox(
          width: 4.0,
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
      CreateMouState.task != null
          ? buildUploadStatus(CreateMouState.task!)
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
                    MaterialStateProperty.all(const Color(0xFFF2C32C))),
            onPressed: () {
              // CreationDetails.mapping(FirebaseApi.downloadUrl, "downloadLink");
              // CreationDetails.addData();
              Navigator.of(cnt).pushNamed('/create_mou');
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
