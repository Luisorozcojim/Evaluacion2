class WeatherModel {
  late int id;
  late String main;
  late String description;
  late String icon;

  WeatherModel(int id, String main, String description, String icon){
    this.id = id;
    this.main = main;
    this.description = description;
    this.icon = icon;
  }
}