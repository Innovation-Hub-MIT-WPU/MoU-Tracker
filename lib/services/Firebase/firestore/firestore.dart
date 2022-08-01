import 'package:MouTracker/classes/mou.dart';
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
  // String uid; // user id of every user. -> required addition - same person can have multiple designations so store them all.
  // DataBaseService({required this.uid});
  String? uid;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference mou = FirebaseFirestore.instance.collection('MOUs');
  final CollectionReference activity =
      FirebaseFirestore.instance.collection('activity');

  Future updateActivityData(String name, String desc, bool isApproved) async {
    return await activity.doc(name).set({
      'name': name,
      'desc': desc,
      'status': isApproved,
    });
  }

  Future addUserDetails(String name, String designation) async {
    await mou
        .doc(name)
        .collection('userDetails')
        .doc()
        .set({'name': name, 'designation': designation});
  }

  Future updateMouData(
      String name, String desc, int id, bool isApproved) async {
    return await mou.doc(name).set({
      'name': name,
      'desc': desc,
      'id': id,
      'status': isApproved,
    });
  }

  List<MOU> _mouListFromDB(snapshot) {
    return snapshot.docs.map((doc) {
      return MOU(
        docName: snapshot.doc['name'],
        authName: "",
        amount: doc['amount'],
        description: doc['desc'],
        day: 2,
        month: "",
        year: 2002,
        index: 0,
        isApproved: false,
        companyName: '',
      );
    }).toList();
  }

  Stream<List<MOU>> get mouData {
    return mou.snapshots().map(_mouListFromDB);
  }

  Stream<DocumentSnapshot> get userData {
    return users.doc().snapshots();
  }
}
