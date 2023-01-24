import 'package:MouTracker/classes/firebase_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../screens/mou_creation/mou_creation_page.dart';
import 'dart:io' as io;

class FirebaseApi {
  static var downloadUrl;
  static late Reference fileReference;
  static Future fileUpload(String docName) async {
    if (CreateFormState.file == null) {
      print("not done");
      return;
    } else {
      String filename = (CreateFormState.file!.path).split('/').last;
      final location = '$docName';

      CreateFormState.task =
          FirebaseApi.uploadTask(location, CreateFormState.file!);
      final snapshot = await CreateFormState.task!.whenComplete(() {});
      fileReference = snapshot.ref;
      downloadUrl = await snapshot.ref.getDownloadURL();
      print("url $downloadUrl");
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
    final ref = FirebaseStorage.instance.ref('test/');
    final result = await ref.listAll();
    final url = await result.items[0].getDownloadURL();
    final ref2 = result.items[0];
    final name = ref2.name;
    final file = FirebaseFile(ref: ref2, name: name, url: url);

    try {
      final io.Directory systemTempDir = io.Directory.systemTemp;
      final io.File tempFile =
          io.File('/storage/emulated/0/Download/temp${ref.name}');
      if (tempFile.existsSync()) await tempFile.delete();

      await ref.writeToFile(tempFile);

      print('${systemTempDir.path}/temp${ref.name}'
          // 'Success!\n Downloaded ${ref.name} \n from bucket: ${ref.bucket}\n '
          // 'at path: ${ref.fullPath} \n'
          // 'Wrote "${ref.fullPath}" to tmp-${ref.name}',
          );
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
