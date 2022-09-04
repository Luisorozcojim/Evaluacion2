import 'package:evaluacion/consts/constants.dart';
import 'package:evaluacion/db/database_user.dart';
import 'package:evaluacion/models/weather_model.dart';
import 'package:evaluacion/screens/menu.dart';
import 'package:evaluacion/screens/register.dart';
import 'package:evaluacion/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;


class Login extends StatefulWidget {
 const Login({ Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _user = TextEditingController();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Location location = new Location();
  WeatherModel? weatherModel;

  late bool _serviceEnabled;
  late  PermissionStatus _permissionGranted;
  late LocationData _locationData;
  bool _notificationsEnabled = false;


  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    weatherModel = await WeatherService.getWeather(_locationData.latitude, _locationData.longitude);
  }



  @override
  void initState() {
    // TODO: implement initState
    _requestPermissions();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 40,),
              SizedBox(
                child: Image.asset('images/logo.png', fit: BoxFit.fill, height: 200, width: 200,),
              ),
              SizedBox(height: 40,),
              Form(
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _user,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFFA8072),
                            ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        obscureText: true,
                        controller: _pass,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFFA8072),
                                ),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                        ),
                      ),
                      const SizedBox(height: 30,),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              DatabaseUser.instance.readUser(_user.text, _pass.text).then((user) {

                               Get.off(() => Menu(weather: weatherModel, userModel: user,));
                              });

                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFFA8072),
                              ),
                            ),
                            child: Text("Login"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {

                            Get.off(() => Register());
                          },

                          child: Text("Sign in",
                            style: TextStyle(color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
