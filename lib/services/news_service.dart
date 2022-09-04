import 'dart:convert';

import 'package:evaluacion/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsService{
  static Future<List<NewsModel>> getNews() async{
    List<NewsModel> news = [];
  await http.get(Uri.parse("https://newsdata.io/api/1/news?apikey=pub_108395e8b3100c2193f88750cfef1979a66bc&q=guadalajara")).then((response) {
      String uftConv = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(uftConv);
      int i =0;
      for(var data in jsonData['results']){
        print(data);
        i++;
        news.add(NewsModel(data['title'], data['content'], 'images/gdl$i.jpg'));
        if(i==4){
          return;
        }
      }

    });
    return news;
  }
}