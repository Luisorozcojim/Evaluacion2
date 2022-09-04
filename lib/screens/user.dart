import 'package:evaluacion/models/user_model.dart';
import 'package:evaluacion/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class User extends StatefulWidget {
  UsersModel? user;
  User({this.user, Key? key}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();



  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'Goodbye', 'See you soon ${widget.user!.name}', platformChannelSpecifics,
        payload: 'item x');
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          margin: EdgeInsets.only(top: 60),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('images/avatar.jpg'),
                    ),
                    Text('Hello ${widget.user!.name}',
                        style: TextStyle(fontSize: 22),
                    ),
                    IconButton(onPressed: (){},
                      icon: Icon(Icons.notifications),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Ajustes de cuenta'),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text('Idioma'),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Soporte'),
                ),

                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(()=> const Login());
                      _showNotification();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.red,
                      ),
                    ),
                    child: Text("Log out"),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
