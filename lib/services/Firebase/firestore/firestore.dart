import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
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

  // Future addUserDetails(String name, String designation) async {
  //   await mou
  //       .doc(name)
  //       .collection('userDetails')
  //       .doc()
  //       .set({'name': name, 'designation': designation});
  // }

  Future updateMouData({
    required int approved,
    required String desc,
    required String docName,
    required String companyName,
    required bool isApproved,
  }) async {
    try {
      await db.collection('mou').add({
        'approval-lvl': approved,
        'description': desc,
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

  Future<UserModel> get userData async {
    String uid = FireAuth().getCurrentUser()!.uid;
    var snap = await users.doc(uid).get();
    print(snap.data());
    return UserModel.fromMap(snap);
  }
}
