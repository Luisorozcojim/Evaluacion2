import 'package:evaluacion/consts/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class News extends StatelessWidget {
  String? title;
  String? description;
  String? img;

  News({this.title, this.description, this.img, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
          preferredSize: Size.fromHeight(120.0), // here the desired height
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            height: 100,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white
                  ),
                ),
                Spacer(),
                Text('NEWS',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),
                ),
                Spacer(),
              ],
            ),
          )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  this.img!,
                  height: 300,
                  width: double.infinity,
                ),
                Text(this.title!,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20,),
                Text(this.description!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
