import 'package:MouTracker/classes/file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../screens/mou_creation/mou_creation_page.dart';
import 'dart:io' as io;

class FirebaseApi {
  static var downloadUrl;
  static Future fileUpload(String folder) async {
    if (CreateFormState.file == null) {
      print("not done");
      return;
    } else {
      String filename = (CreateFormState.file!.path).split('/').last;
      final location = '$folder/$filename';

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

  static Future download(String path) async {
    final ref = FirebaseStorage.instance.ref('/$path');
    final result = await ref.listAll();
    print("hey${result.items[0].name}");
    final url = await result.items[0].getDownloadURL();
    final ref2 = result.items[0];
    final name = ref2.name;
    final file = FirebaseFile(ref: ref2, name: name, url: url);

    try {
      final io.Directory systemTempDir = io.Directory.systemTemp;
      final io.File tempFile = io.File('/storage/emulated/0/Download/$name');

      await ref2.writeToFile(tempFile);
    } catch (e) {
      print(e);
    }
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
