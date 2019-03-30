import 'package:flutter/material.dart';
import 'package:waether_application/background/Mid_Menu.dart';
import 'package:waether_application/background/BackGroundWithRings.dart';
import 'package:waether_application/presentations/temperature_icons.dart';


class MainPage extends StatelessWidget {

  double temperature;
  String status,wind,humidity,minTemp,maxTemp,cloudy='Clouds';
  MainPage({
    @required this.temperature,
    @required this.status,
    @required this.humidity,
    @required this.wind,
    @required this.minTemp,
    @required this.maxTemp,
});
  Widget _temprature(String temp,String maxTemp,String minTemp){
    return new Align(
      alignment: Alignment.centerLeft ,
      child: new Row(
        children: <Widget>[
          Icon(Temperature.temperature,size: 80.0,),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.only(top: 290.0,left: 5.0),
                child: Column(
                  children: <Widget>[
                    Text(minTemp==null?'':minTemp,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                      ),
                    ),
                    Text(temp,
                      style: TextStyle(
                          color:  status=='Clear'?Colors.indigoAccent:Colors.white,
                          fontSize: 38.0,
                      ),
                    ),
                    Text(maxTemp==null?'':maxTemp,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                      ),
                    ),
                  ],
                ),
              )
          )
        ],
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        BackGroundWithRings(daytime: 'Day',status: status,),
        Mid_Menu(humidity: humidity,wind: wind,status: status,),
        _temprature(temperature==null?'op':temperature.toStringAsFixed(2),maxTemp,minTemp),

      ],
    );
   }
  }
