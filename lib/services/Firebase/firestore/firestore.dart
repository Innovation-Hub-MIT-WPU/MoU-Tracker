import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  // Collections for storing data in the cloud firestore.
  // Structure -
  /* 
      Mou collection 

        |_ Document -> MOU
              |_ Mou details
                 Activity collection
                    |_ Activity docs
                          |_ Activity details
  */

  final db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  late final CollectionReference mou =
      FirebaseFirestore.instance.collection('mou');
  final CollectionReference activity =
      FirebaseFirestore.instance.collection('activity');

  Future updateActivityData(String name, String desc, bool isApproved) async {
    return await activity.doc(name).set({
      'name': name,
      'desc': desc,
      'status': isApproved,
    });
  }

  // Future addUserDetails(String name, String designation) async {
  //   await mou
  //       .doc(name)
  //       .collection('userDetails')
  //       .doc()
  //       .set({'name': name, 'designation': designation});
  // }

  Future updateMouData({
    required String id,
    required String desc,
    required String docName,
    required String companyName,
    required bool isApproved,
  }) async {
    try {
      await db.collection('mou').add({
        'id': id,
        'desc': desc,
        'doc-name': docName,
        'company-name': companyName,
        'status': isApproved,
      });
    } catch (err) {
      print("error - $err");
    }
  }

  List _getMouList(snapshot) {
    return snapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }

  Stream<List> getmouData() {
    Stream<List> mouList = mou.snapshots().map(_getMouList);
    // snapshot -> list of documents containing mou-data
    // mouList
    return mouList;
  }

  Stream<DocumentSnapshot> get userData {
    return users.doc().snapshots();
  }
}
