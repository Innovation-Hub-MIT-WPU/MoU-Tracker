import 'package:MouTracker/common_utils/utils.dart';
import 'package:MouTracker/models/activity.dart';
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
    required int approved,
    required DateTime dueDate,
    required String desc,
    required String docName,
    required String tenure,
    required String authName,
    required String authDesignation,
    required String spocName,
    required String spocNo,
    required String spocDesignation,
    required String companyName,
    required String companyWebsite,
    required String companyEmployees,
    required String companyAddress,
    required String companyDomain,
    required String companyTurnOver,
    required bool isApproved,
  }) async {
    try {
      mouData = await db.collection('mou').add({
        'approval-lvl': approved,
        'spoc-name': spocName,
        'spoc-no': spocNo,
        'spoc-designation': spocDesignation,
        'auth-name': authName,
        'auth-designation': authDesignation,
        'doc-name': docName,
        'tenure': tenure,
        'company-name': companyName,
        'company-employees': companyEmployees,
        'company-address': companyAddress,
        'company-domain': companyDomain,
        'company-turnover': companyTurnOver,
        'company-website': companyWebsite,
        'status': isApproved,
        'description': desc,
        'due-date': dueDate,
        'creation-date': DateTime.now(),
      });
    } catch (err) {
      // print("error - $err");
    }
    return mouData.id;
  }

  Future updateApprovalLvl({required String mouId, required int appLvl}) async {
    await mou.doc(mouId).update({'approval-lvl': appLvl});
  }

  Future updateDesignation({required String userId, required int pos}) async {
    await users.doc(userId).update({'pos': pos});
    await users.doc(userId).update({'designation': designations[pos]});
  }

  Future updateEngagementList({
    required String mouId,
    required String activityName,
    required String activityDesc,
  }) async {
    await mou.doc(mouId).update({
      'activities': FieldValue.arrayUnion([
        {
          'activity-name': activityName,
          'activity-desc': activityDesc,
          'status': true
        }
      ])
    });
  }

  // Function to upload Activity details on Firebase, returns the id of the uploaded activity.
  // id is to be added as a reference in its MOU
  Future<String> uploadEngagementData(
      {required String activityName,
      required String mouId,
      required Map<String, dynamic> data}) async {
    DocumentReference activity = db.collection(activityName).doc(mouId);
    await activity.set(data);
    return activity.id;
  }

  Future<String> uploadEngagementsWithSubcollectionData(
      {required String activityName,
      required String year,
      required String mouId,
      required Map<String, dynamic> data}) async {
    CollectionReference activity =
        db.collection(activityName).doc(mouId).collection(year);
    await activity.add(data);
    return activity.id;
  }

  Future<Map> getEngagementData(
      {required String collId, required String docId, String? year}) async {
    var querySnap = await db.collection(collId).doc(docId).get();
    final activityData = querySnap.data()!;
    return activityData;
  }

  Future<List<Map>> getPlacementData(
      {required String collId,
      required String docId,
      required String year}) async {
    var querySnap =
        await db.collection(collId).doc(docId).collection(year).get();
    var docs = querySnap.docs;
    List<Map<String, dynamic>> activityData = [];
    docs.forEach((doc) {
      activityData.add(doc.data());
    });
    return activityData;
  }

  Future<List> getEngagementList({required String mouId}) async {
    DocumentSnapshot docSnap = await mou.doc(mouId).get();
    List snapList = docSnap.get('activities');
    List<Activity> res = snapList.map((data) {
      // print(data['activity-name']);
      return Activity(
        name: data['activity-name'],
        desc: data['activity-desc'],
        status: data['status'],
      );
    }).toList();

    // print(res);
    return res;
  }

  Future<List<MOU>> getmouData() async {
    var querySnap = await mou.get();
    final List<MOU> mouList = querySnap.docs.map((doc) {
      String mouId = doc.id;
      DateTime date = doc['due-date'].toDate();
      DateTime creationDate = doc['creation-date'].toDate();
      String createdOn =
          "${creationDate.year}-${creationDate.month}-${creationDate.day}";
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
        createdDate: createdOn,
        spocDesignation: doc['spoc-designation'],
        spocName: doc['spoc-name'],
        spocNo: doc['spoc-no'],
        authDesignation: doc['auth-designation'],
        companyAddress: doc['company-address'],
        companyDomain: doc['company-domain'],
        companyEmployees: doc['company-employees'],
        companyTurnOver: doc['company-turnover'],
        tenure: doc['tenure'],
        dueDate: dueDate,
        due: date,
        createdOn: creationDate,
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
      // print("error - $err");
    }
  }

  Future<List> getStats(String type, String year) async {
    var querySnap = await db
        .collection('stats')
        .doc(type)
        .get()
        .then((value) => value.data());
    final stats = querySnap![year] as List;
    // print("$type :- $stats");
    await Future.delayed(const Duration(seconds: 2));
    return stats;
  }

  Future addDataToStats(String type, String year, int month) async {
    List stats = await getStats(type, year);
    stats[month + 1] = stats[month + 1] + 1;
    var querySnap =
        await db.collection('stats').doc(type).update({year: stats});
    // print("$type :- $stats");
  }
}
