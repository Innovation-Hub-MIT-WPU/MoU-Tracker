import 'dart:convert';
import 'package:MouTracker/models/mou.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
import 'package:MouTracker/services/Firebase/fireauth/model.dart';
import 'package:MouTracker/services/Firebase/firestore/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin localNotifPlugin =
      FlutterLocalNotificationsPlugin();
  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void addToken() async {
    var token = await messaging.getToken();
    print("get token : $token");
    UserModel model = await DataBaseService().getuserData();
    var list = [token];
    await FirebaseFirestore.instance
        .collection('deviceTokens')
        .doc(model.pos.toString())
        .update({"tokens": FieldValue.arrayUnion(list)});
  }

  void deteleToken(String pos) async {
    var token = await messaging.getToken();
    print("delete token : $token");
    var list = [token];
    print("token deleted $list from ${pos}");

    await FirebaseFirestore.instance
        .collection('deviceTokens')
        .doc(pos)
        .update({"tokens": FieldValue.arrayRemove(list)});
  }

  void checkNotifications(BuildContext context) async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInitialize = DarwinInitializationSettings();

    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    localNotifPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        onOpenForeNotification(notificationResponse.payload!, context);
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage: $message.notification");

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          const AndroidNotificationDetails(
        'team_mou',
        'team_mou_id',
        importance: Importance.max,
        priority: Priority.max,
        playSound: false,
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await localNotifPlugin.show(0, message.notification?.title,
          message.notification?.body, platformChannelSpecifics,
          payload: message.data['mou_id']);
      print("payload ${message.data['mou_id']}");
    });
  }

  void onOpenBackNotification(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      var mouId = message.data['mou_id'];
      var query = await FirebaseFirestore.instance
          .collection('mou')
          .doc(mouId.trim())
          .get();

      final data = query.data();
      DateTime date = data!['due-date'].toDate();
      String dueDate = "${date.year}-${date.month}-${date.day}";

      MOU mou = MOU(
          mouId: mouId.trim(),
          docName: data['doc-name'],
          authName: data['auth-name'],
          companyName: data['company-name'],
          companyWebsite: data['company-website'],
          description: data['description'],
          isApproved: data['status'],
          appLvl: data['approval-lvl'],
          due: date,
          dueDate: dueDate);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                    mou: mou,
                  )));
    });
  }

  void onOpenForeNotification(String payload, BuildContext context) async {
    var mouId = payload;
    var query = await FirebaseFirestore.instance
        .collection('mou')
        .doc(mouId.trim())
        .get();

    final data = query.data();
    DateTime date = data!['due-date'].toDate();
    String dueDate = "${date.year}-${date.month}-${date.day}";

    MOU mou = MOU(
        mouId: mouId.trim(),
        docName: data['doc-name'],
        authName: data['auth-name'],
        companyName: data['company-name'],
        companyWebsite: data['company-website'],
        description: data['description'],
        isApproved: data['status'],
        appLvl: data['approval-lvl'],
        due: date,
        dueDate: dueDate);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Details(
                  mou: mou,
                )));
  }

  void sendPushMessage(String body, String title, String mouId, int pos) async {
    for (var position = 0; position < pos; position++) {
      var query = await FirebaseFirestore.instance
          .collection('deviceTokens')
          .doc(position.toString())
          .get();

      var doc = query.data();
      List tokens = doc!['tokens'];
      for (var i = 0; i < tokens.length; i++) {
        try {
          var responce =
              await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
                  headers: <String, String>{
                    'Content-Type': 'application/json',
                    'Authorization':
                        'key=AAAACuqX0A0:APA91bGkROQ4fssNIbcdMOYwmyCq4t5IIjDTYzlRkCW4tpjQYqwkszVOgS0UvKXmEx_Y9DfZiLs7cGudph1wTlsB1fo2WEQIVzgf43vqKj6YscQa6ngvxZ289P-y9hkf4V69x473XkkI'
                  },
                  body: jsonEncode(<String, dynamic>{
                    "notification": <String, dynamic>{
                      "body": body,
                      "title": title,
                    },
                    "to": tokens[i],
                    'priority': 'high',
                    'data': <String, dynamic>{
                      "click_action": "FLUTTER_NOTIFICATION_CLICK",
                      "id": "1",
                      "status": "done",
                      "body": body,
                      "title": title,
                      "mou_id": mouId
                    }
                  }));
        } catch (e) {
          print(e);
        }
      }
    }
  }
}
