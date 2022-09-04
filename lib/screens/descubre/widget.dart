import 'package:evaluacion/screens/descubre/descubre_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget tile (String name, List<String> imgs, String info, LatLng latlng){
  return Card(
    elevation: 8,
    shape:  OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.white)
    ),
    child: SizedBox(
      height: 80,
      child: ListTile(
        title: Text(name),
        subtitle: const Text('Discover this fantastic place!'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(imgs[0], height: 100, width: 100, fit: BoxFit.fill, alignment: Alignment.center,),
        ),
        onTap: (){
          Get.to(DescubreDetail(name: name, imgs: imgs, info: info, latlng: latlng,));
        },
      ),
    ),
  );
}