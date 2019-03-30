import 'dart:async';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:weather/weather.dart';

class FetchData{
  double temp,minTemp,maxTemp;
  String description,humidity,wind,city;
  FetchData({this.temp,this.description,this.wind,this.humidity,this.city,this.maxTemp,this.minTemp});

  factory FetchData.fromJson(Map<String, dynamic> parsedJson) {
    return FetchData(
        temp: parsedJson['main']['temp']-273.15,
        description: parsedJson['weather'][0]['description'],
        wind: parsedJson['wind']['speed'].toString(),
        humidity: parsedJson['main']['humidity'].toString(),
        city: parsedJson['name'],
        maxTemp: parsedJson['main']['temp_max']-273.15,
        minTemp: parsedJson['main']['temp_min']-273.15,

    );
  }
}

class Fetch {

  Future<String> getLocation () async {
    Map<String, double> loc = await Location().getLocation();
    double lat = loc['latitude'];
    double lon = loc['longitude'];
    print(lat);
    return 'https://api.darksky.net/forecast/d9dbb3876492b2a8099dce7e31571e41/$lat,$lon';
  }

  Future<FetchData> getWeather () async {
    String url;
    url = await getLocation();
    http.Response response = await http.get(url);
    Map<String, dynamic> weather = json.decode(response.body);
    print(weather);
    return FetchData.fromJson(weather);
  }
}


