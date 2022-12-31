import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../screens/mou_creation/mou_creation_page.dart';
import 'dart:io' as io;

class FirebaseApi {
  static var downloadUrl;
  static Future fileUpload() async {
    if (CreateFormState.file == null) {
      print("not done");
      return;
    } else {
      String filename = (CreateFormState.file!.path).split('/').last;
      final location = 'mou1/$filename';

      CreateFormState.task =
          FirebaseApi.uploadTask(location, CreateFormState.file!);
      final snapshot = await CreateFormState.task!.whenComplete(() {});
      downloadUrl = await snapshot.ref.getDownloadURL();
      print("done");
    }
  }

  static UploadTask? uploadTask(String location, io.File file) {
    try {
      final refer = FirebaseStorage.instance.ref(location);
      return refer.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
    return null;
  }
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Text(
            '$percentage %',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return const Text("Uploading...");
        }
      },
    );
