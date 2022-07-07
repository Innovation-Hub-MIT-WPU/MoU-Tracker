// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import '/screens/mou_creation/fields.dart';
// import 'dart:io' as io;
// import '/services/Firebase/firestore/upload_service.dart';

// class CreateMou extends StatefulWidget {
//   const CreateMou({Key? key}) : super(key: key);

//   @override
//   State<CreateMou> createState() => CreateMouState();
// }

// class CreateMouState extends State<CreateMou> {
//   static UploadTask? task;
//   static io.File? file;
//   late Future<List<FirebaseFile>> _future;

//   @override
//   void initState() {
//     super.initState();

//     // _future = FirebaseApi.listAll('/files11');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 100,
//         backgroundColor: const Color(0xFF2D376E),
//         title: title("CREATE MOU"),
//       ),
//       body: Form(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 0.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               fields("Field -1", "MOU NAME"),
//               const SizedBox(height: 20),
//               fields("Field -2", "Created On : Date"),
//               const SizedBox(height: 20),
//               fields("Field -3", "Description"),
//               const SizedBox(height: 20),
//               fields("Field -4", "Due Date"),
//               const SizedBox(height: 20),
//               fields("Field -5", "field5"),
//               const SizedBox(height: 20),
//               fields("Field -6", "field6"),
//               const SizedBox(height: 20),
//               Text(file == null
//                   ? "no file selected"
//                   : file!.path.split('/').last),
//               button1(pickFile),
//               OutlinedButton(
//                 onPressed: () {
//                   FirebaseApi.fileUpload();
//                   showDialog(
//                       barrierDismissible: false,
//                       context: context,
//                       builder: (BuildContext context) {
//                         return dialog(context);
//                       });
//                 },
//                 child: const Text("Done"),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }

//   Future pickFile() async {
//     final result = await FilePicker.platform.pickFiles(allowMultiple: false);
//     if (result == null) {
//       print("result null");
//       return;
//     } else {
//       final filepath = result.files.single.path!;

//       setState(() {
//         file = io.File(filepath);
//       });
//     }
//   }
// }
