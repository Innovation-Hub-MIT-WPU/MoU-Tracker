import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  void checkNotifications() async {
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
          payload: message.data['title']);
    });
  }

  void sendPushMessage(String body, String title) async {
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
                  "title": title
                }
              }));
      print(responce.body);
    } catch (e) {
      print(e);
    }
  }
}
