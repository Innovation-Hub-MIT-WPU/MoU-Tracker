import 'dart:convert';

import 'package:MouTracker/classes/mou.dart';
import 'package:MouTracker/screens/mou_details/mou_details_page.dart';
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

  void getToken() async {
    await messaging.getToken().then((value) => print("token= $value"));
  }

  void checkNotifications(BuildContext context) async {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInitialize = DarwinInitializationSettings();

    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    localNotifPlugin.initialize(initializationsSettings);
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
          payload: message.data['doc_name']);
    });
  }

  void openNotification(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");
      var doc_name = message.data['doc_name'];
      var query = await FirebaseFirestore.instance
          .collection('mou')
          .where('doc-name', isEqualTo: doc_name)
          .get();
      String mouId = "";
      DateTime date;
      String dueDate = "";
      final data = query.docs.map((doc) {
        mouId = doc.id;
        date = doc['due-date'].toDate();
        dueDate = "${date.year}-${date.month}-${date.day}";
        return doc.data();
      }).toList();

      MOU mou = MOU(
          mouId: mouId,
          docName: data[0]['doc-name'],
          authName: data[0]['auth-name'],
          companyName: data[0]['company-name'],
          description: data[0]['description'],
          isApproved: data[0]['status'],
          appLvl: data[0]['approval-lvl'],
          dueDate: dueDate);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Details(mou: mou)));
    });
  }

  void sendPushMessage(String body, String title, String doc_name) async {
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
                "to": "/topics/test-1",
                'priority': 'high',
                'data': <String, dynamic>{
                  "click_action": "FLUTTER_NOTIFICATION_CLICK",
                  "id": "1",
                  "status": "done",
                  "body": body,
                  "title": title,
                  "doc_name": doc_name
                }
              }));
    } catch (e) {
      print(e);
    }
  }
}
