import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // ignore: prefer_const_declarations

  ////////////////////////////////////////////////////////////////////////////////
  static void initialize(BuildContext context) async {
    // ignore: prefer_const_declarations
    final InitializationSettings initializationSettings =
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      print("payload: $payload");

      if (payload != null) {
        Navigator.pushNamed(
            context,
            payload);
      }
    });
  }

  ///////////////////////////////////////////////////
  static void display(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // ignore: prefer_const_constructors
    try {
      final NotificationDetails notificationDetails = NotificationDetails(
        // ignore: prefer_const_constructors
        android: AndroidNotificationDetails(
          "easyapproach",
          "easyapproach channel",
          importance: Importance.max,
          priority: Priority.high,
        ),
      );

      await flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["route"]);
    } on Exception catch (e) {
      print(e);
    }
  }
}
