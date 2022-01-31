// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:noti/pageone.dart';
import 'package:noti/pagesecond.dart';
import 'package:noti/services/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print("backgroundHandler");
  print(message.data.toString());
  print(message.notification);
  print(message.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        'one': (BuildContext context) => const One(),
        'two': (BuildContext context) => const Two(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);

    /// give a message on which a user on user taped its openedd the app frrom terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final route = message.data["route"];
        // ignore: avoid_print
        print(route);

        if (route == "one") {
          Navigator.pushNamed(context, "one");
        } else if (route == "two") {
          Navigator.pushNamed(context, "two");
        }
      }
      print(message.toString());
    });

    // forground notification
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        // ignore: avoid_print
        print(message.notification!.title);
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });

    // background notification open app  user tap////
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        final route = message.data["route"];
        // ignore: avoid_print
        print(route);

        if (route == "one") {
          Navigator.pushNamed(context, "one");
        } else if (route == "two") {
          Navigator.pushNamed(context, "two");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
