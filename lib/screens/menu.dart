import 'package:evaluacion/consts/constants.dart';
import 'package:evaluacion/models/user_model.dart';
import 'package:evaluacion/models/weather_model.dart';
import 'package:evaluacion/screens/home.dart';
import 'package:evaluacion/screens/login.dart';
import 'package:evaluacion/screens/descubre/descubre.dart';
import 'package:evaluacion/screens/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Menu extends StatefulWidget {
  WeatherModel? weather;
  UsersModel? userModel;
   Menu({this.weather, this.userModel, Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  int _selectedIndex = 0;


  late List<Widget> _widgetOptions;


  Future<bool> _onWillPop() async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      setState(() {
        _scaffoldKey.currentState!.openEndDrawer();
      });
    }
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return Future.value(false);
    }
    // This dialog will exit your app on saying yes
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('¿Desea salir?'),
        content: new Text('Esta acción hará que se cierre tu sesión'),
        actions: <Widget>[
          new ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(
              'No',
              style: TextStyle(color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 10, primary: Colors.white),
          ),
          new ElevatedButton(
            onPressed: () => Get.offAll(() => Login()),
            child: new Text(
              'Si',
              style: TextStyle(color: Colors.red),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 10, primary: Colors.white),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  void initState() {
    // TODO: implement initState
    _widgetOptions = <Widget>[
      Home(userModel: widget.userModel, weather: widget.weather),
      Descubre(),
      User(user: widget.userModel,),
    ];
    _selectedIndex = 0;
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.zero,
          top: false,
          child: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),

          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),

          // i have found out the height of the bottom navigation bar is roughly 60

          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false, // <-- HERE
            showUnselectedLabels: false,

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                activeIcon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: SizedBox(
                    width: 50,
                    height: 10,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          top: -30,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF40CFFF),
                                ),
                                child: Icon(Icons.home),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note),
                label: 'Travels',
                activeIcon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: SizedBox(
                    width: 50,
                    height: 10,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          top: -30,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF40CFFF),
                                ),
                                child: Icon(Icons.event_note),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
                activeIcon: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  child: SizedBox(
                    width: 60,
                    height: 10,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          top: -30,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Color(0xFF40CFFF),
                                ),
                                child: Icon(Icons.person),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            currentIndex: _selectedIndex <= 3 ? _selectedIndex : 0,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
            unselectedItemColor: Colors.white,
          ),
        ),
      ),
    );
  }

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
