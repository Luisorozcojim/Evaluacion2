import 'package:evaluacion/consts/constants.dart';
import 'package:evaluacion/db/database_user.dart';
import 'package:evaluacion/models/user_model.dart';
import 'package:evaluacion/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';


class Register extends StatefulWidget {
  const Register({ Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _user = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
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
                key: _form,
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _user,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'User name is required';
                          }
                          if (value.length <= 3) {
                            return 'User name must have at least 4 characters';
                          }
                          return null;
                        },
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
                        controller: _pass,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length <= 7){
                            return 'Password must have at least 8 characters';
                          }
                          if(!value.contains(RegExp(r'\W')) && RegExp(r'\d+\w*\d+').hasMatch(value)){
                            return 'Password must have at least 1 upper case, 1 lower case,\n1 numeric,and 1 special character';
                          }
                          return null;
                        },
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
                            if (_form.currentState!.validate()) {
                              DatabaseUser.instance.createObject(
                                  UsersModel(name: _user.text, password: _pass.text)).then((value) {
                                Fluttertoast.showToast(
                                    msg: "You were registered successfully",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primaryColor,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Get.off(() => Login());
                              });
                            }
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
                          child: Text("Register"),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {

                              Get.back();
                          },
                          child: Text("Back",
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
