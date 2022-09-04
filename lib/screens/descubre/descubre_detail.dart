import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:evaluacion/consts/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DescubreDetail extends StatefulWidget {
  List<String>? imgs;
  String? info;
  String? name;
  LatLng? latlng;
  DescubreDetail({this.imgs, this.name, this.latlng, this.info, Key? key}) : super(key: key);

  @override
  _DescubreDetailState createState() => _DescubreDetailState();
}

class _DescubreDetailState extends State<DescubreDetail> {

  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition _kGooglePlex;
  late List<Widget> imageSliders;

  @override
  void initState() {
    // TODO: implement initState
    _kGooglePlex = CameraPosition(
      target: widget.latlng!,
      zoom: 15,
    );
    imageSliders = widget.imgs!
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          ),
        ),
      ),
    ).toList();
    super.initState();
  }


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
                Text('Discover ${widget.name}',
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
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
              SizedBox(
                height: 30,
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.info!,
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20,),
                    Text('Map from ${widget.name!}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              SizedBox(
                height: 300,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

