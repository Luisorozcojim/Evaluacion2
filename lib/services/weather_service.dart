import 'dart:convert';
import 'package:evaluacion/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static Future<WeatherModel> getWeather(lat, lon) async{
    late WeatherModel weather;
    // await http.get(Uri.parse("https://newsdata.io/api/1/news?apikey=pub_108395e8b3100c2193f88750cfef1979a66bc&q=guadalajara")).then((response) {
    await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=090486a7db3a86913af693d79341dfe6")).then((response) {
      String uftConv = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(uftConv);
      print(jsonData);
      
      weather = WeatherModel(jsonData['weather'][0]['id'], jsonData['weather'][0]['main'], jsonData['weather'][0]['description'], 'http://openweathermap.org/img/wn/${jsonData['weather'][0]['icon']}@2x.png');
    });
    return weather;
  }
}