import 'dart:io';

import 'package:MouTracker/models/file.dart';
import 'package:MouTracker/models/personalized_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'dart:io' as io;

import '../../../screens/mou_creation/mou_creation_page.dart';

class FirebaseApi {
  static var downloadUrl;

  static String downloadPath = '/storage/emulated/0/Download';
  static late DownloaderUtils options;
  static late DownloaderCore core;

  static Future fileUpload(String folder, File? file) async {
    if (file == null) {
      print("not done");
      return;
    } else {
      String filename = (file.path).split('/').last;
      final location = '$folder/$filename';

      CreateFormState.task = FirebaseApi.uploadTask(location, file);
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

    // print("hey${result.items[0].name}");
    final url = await result.items[0].getDownloadURL();
    print('url: $url');
    final FullMetadata metaData = await result.items[0].getMetadata();
    // print('${metaData.name} is ${metaData.size} bytes');
    // print('metaData.contentType: ${metaData.contentType}');
    String extensionName = metaData.contentType.toString().split('/').last;

    if (extensionName ==
        'vnd.openxmlformats-officedocument.wordprocessingml.document') {
      extensionName = 'docx';
    }
    print('extensionName: $extensionName');
    final ref2 = result.items[0];
    final name = ref2.name;
    final file = FirebaseFile(ref: ref2, name: name, url: url);

    // check if file already exists
    if (File('$downloadPath/MoU-Tracker/$name').existsSync()) {
      print('File already exists');
      OpenFile.open('/storage/emulated/0/Download/MoU-Tracker/$name');
      return;
    }

    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        // print('Downloading: $progress');
        // print('$path/$fileName.pdf');
      },

      // folder struucture to save the file
      file: File('$downloadPath/MoU-Tracker/$name'),
      progress: ProgressImplementation(),
      onDone: () {
        OpenFile.open('/storage/emulated/0/Download/MoU-Tracker/$name');
        print(
            'Download completed. File saved at /storage/emulated/0/Download/MoU-Tracker/$name');
      },
      deleteOnCancel: true,
    );
    core = await Flowder.download(
      url,
      options,
    );
  }
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return PText(
            '$percentage %',
            style:
                GoogleFonts.figtree(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return const PText("Uploading...");
        }
      },
    );
