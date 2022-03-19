import 'package:event_spotter/pages/landing.dart';
import 'package:event_spotter/pages/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:event_spotter/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp();
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//       .then((_) {
//     runApp( const MaterialApp(
//       home:  LoginScreen(),
//       debugShowCheckedModeBanner: false,
//     ));
//   });

// }
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print(message.notification!.title);
  print(message.notification!.body);
  var flutterLocalNotificationsPlugin;
  flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  void initState() {
    var initializationSettingAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var intializationSetting =
        InitializationSettings(android: initializationSettingAndroid);
    flutterLocalNotificationsPlugin.initialize(intializationSetting);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LandingScreen(),
      // home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// showAlertDialog(BuildContext context) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text("OK"),
//       onPressed: () {},
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text("My title"),
//       content: Text("This is my message."),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }