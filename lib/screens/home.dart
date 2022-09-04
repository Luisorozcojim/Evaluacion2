import 'package:evaluacion/consts/constants.dart';
import 'package:evaluacion/models/news_model.dart';
import 'package:evaluacion/models/user_model.dart';
import 'package:evaluacion/models/weather_model.dart';
import 'package:evaluacion/screens/news.dart';
import 'package:evaluacion/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  WeatherModel? weather;
  UsersModel? userModel;
  Home({this.weather, this.userModel, Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<List<NewsModel>> news;


  late String welcome;

  @override
  void initState() {
    // TODO: implement initState
    news = NewsService.getNews();
    welcome = widget.userModel!.name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 100,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome $welcome!",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                   const Text("We brought this news for you",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: Stack (
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                     child: Container(
                        color: Color(0xFF40CFFF),
                        height:  MediaQuery.of(context).size.height,
                        width:  MediaQuery.of(context).size.width,
                      ),
                    ),
                    widget.weather != null ? Column(
                      children: [
                        Image.network(widget.weather!.icon, height: 100, width: 100,),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(widget.weather!.main,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(widget.weather!.description,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        )
                      ],
                    ) : const Text('Turn on the GPS'),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              FutureBuilder(
                future: news,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return getNewsWidget(snapshot.data!);
                  }
                  else{
                    return CircularProgressIndicator(color: primaryColor,);
                  }
                },
              ),
            ],
          ),
        ),
    );
  }

  Widget getNewsWidget(List<NewsModel> data){
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(data[index].img, fit: BoxFit.cover, width: 80,),
            title: Text(data[index].title),
            onTap: (){
              Get.to(() => News(
                  title: data[index].title,
                  description: data[index].description,
                  img: data[index].img,
                ),
              );
            },
          );
      },
    );
  }
}
