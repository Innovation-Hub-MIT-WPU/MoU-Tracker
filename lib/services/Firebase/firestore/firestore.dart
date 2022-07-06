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
  String uid; // user id of every user. -> required addition - same person can have multiple designations so store them all.
  DataBaseService({required this.uid});
  
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference mou = FirebaseFirestore.instance.collection('mou');
  final CollectionReference activity =
      FirebaseFirestore.instance.collection('activity');

  Future updateActivityData(String name, String desc, bool status) async {
    return await activity
        .doc()
        .set({'name': name, 'desc': desc, 'status': status});
  }

  Future updateMouData(
      String name, String desc, int id, DateTime dateTime) async {
    return await mou
        .doc()
        .set({'name': name, 'desc': desc, 'id': id, 'Date': dateTime});
  }

  Stream<QuerySnapshot> get mouData {
    return mou.snapshots();
  }

  Stream<DocumentSnapshot> get userData {
    return users.doc(uid).snapshots();
  }
}
