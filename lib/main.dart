import 'package:evaluacion/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

String? selectedNotificationPayload;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initNotification();
  runApp(const MyApp());
}

initNotification() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('app_icon');

  final IOSInitializationSettings initializationSettingsIOS =  const IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final MacOSInitializationSettings initializationSettingsMacOS = const MacOSInitializationSettings();

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
