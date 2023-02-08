import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/services/Firebase/fireauth/fireauth.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/notifications_data.dart';

class DataBaseService {
  // Collections for storing data in the cloud firestore.
  // Structure -
  /* 
      Mou collection 
        |_ Document -> MOU
              |_ Mou details
                 Activity References
        
        Activity collection
              |_ Activity details
  
      Queries - 

  
  */

  final db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference mou = FirebaseFirestore.instance.collection('mou');

  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

  final List<NotificationsData> notificationsList = [];

  late DocumentReference mouData;

  // Function to create MOU doc on Firebase, returns the id of created MOU
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
      mouData = await db.collection('mou').add({
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
    return mouData.id;
  }

  Future updateApprovalLvl({required String mouId, required int appLvl}) async {
    await mou.doc(mouId).update({'approval-lvl': appLvl});
  }

  Future updateReferenceId(
      {required String mouId,
      required String refParam,
      required String id}) async {
    await mou.doc(mouId).update({
      'activities': {refParam: id}
    });
  }

  // Function to upload Activity details on Firebase, returns the id of the uploaded activity.
  // id is to be added as a reference in its MOU
  Future<String> uploadEngagementData(
      {required String activityName,
      required Map<String, dynamic> data}) async {
    DocumentReference activity = await db.collection(activityName).add(data);
    return activity.id;
  }

  Future<List> getEngagementData(String collId, String refId) async {
    var querySnap = await db.collection(collId).get();
    final List activityList = querySnap.docs.map((doc) => doc).toList();
    return activityList;
  }

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
          companyWebsite: doc['company-website'],
          description: doc['description'],
          isApproved: doc['status'],
          appLvl: doc['approval-lvl'],
          dueDate: dueDate,
          due: date,
          createdOn: doc['creation-date'].toDate());
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
          mouId: doc['mou_id'],
          title: doc['title'],
          docName: doc['doc_name'],
          on: doc['on'].toDate(),
          due: doc['due'].toDate(),
          body: doc['body'],
          by: doc['by']);
    }).toList();
    return notificationsList;
  }

  Future addNotification(
      {required DateTime on,
      required DateTime due,
      required String mouId,
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
        'on': on,
        'due': due,
        'mou_id': mouId
      });
    } catch (err) {
      print("error - $err");
    }
  }
}
