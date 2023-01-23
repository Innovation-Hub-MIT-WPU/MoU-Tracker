import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../classes/notifications_data.dart';

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

  final CollectionReference mou = FirebaseFirestore.instance.collection('mou');
  final CollectionReference activity =
      FirebaseFirestore.instance.collection('activity');
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  final List<NotificationsData> notificationsList = [];

  Future createMou({
    required DateTime dueDate,
    required int approved,
    required String desc,
    required String docName,
    required String companyName,
    required String authName,
    required String spocName,
    required String companyWebsite,
    required bool isApproved,
  }) async {
    try {
      await db.collection('mou').add({
        'approval-lvl': approved,
        'spoc-name': spocName,
        'auth-name': authName,
        'description': desc,
        'doc-name': docName,
        'company-name': companyName,
        'company-website': companyWebsite,
        'status': isApproved,
        'creation-date': DateTime.now(),
        'due-date': dueDate,
      });
    } catch (err) {
      print("error - $err");
    }
  }

  Future updateApprovalLvl({required String mouId, required int appLvl}) async {
    await mou.doc(mouId).update({'approval-lvl': appLvl});
  }

  // List<MOU> _getMouList(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {

  //     return
  //   }).toList();
  // }

  Future<List<MOU>> getmouData() async {
    var querySnap = await mou.get();
    final List<MOU> mouList = querySnap.docs.map((doc) {
      String mouId = doc.id;
      DateTime date = doc['due-date'].toDate();
      String dueDate = "${date.year}-${date.month}-${date.day}";
      return MOU(
        mouId: mouId,
        docName: doc['doc-name'],
        authName: doc['auth-name'],
        companyName: doc['company-name'],
        description: doc['description'],
        isApproved: doc['status'],
        appLvl: doc['approval-lvl'],
        dueDate: dueDate,
      );
    }).toList();
    return mouList;
  }

  Future<UserModel> getuserData() async {
    String uid = FireAuth().getCurrentUser()!.uid;
    var snap = await users.doc(uid).get();
    return UserModel.fromMap(snap);
  }

  Future<List<NotificationsData>> getNotifications() async {
    var querySnap = await notifications.get();
    final List<NotificationsData> notificationsList = querySnap.docs.map((doc) {
      return NotificationsData(
          title: doc['title'],
          docName: doc['doc_name'],
          on: doc['on'].toDate(),
          body: doc['body'],
          by: doc['by']);
    }).toList();
    return notificationsList;
  }

  Future addNotification(
      {required DateTime on,
      required String body,
      required String by,
      required String doc_name,
      required String title}) async {
    try {
      await db.collection('notifications').add({
        'body': body,
        'by': by,
        'doc_name': doc_name,
        'title': title,
        'on': on
      });
    } catch (err) {
      print("error - $err");
    }
  }
}
