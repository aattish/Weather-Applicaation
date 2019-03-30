import 'package:flutter/material.dart';
import 'package:waether_application/presentations/my_flutter_app_icons.dart';
import 'package:waether_application/presentations/humidity_icons.dart';
import 'package:waether_application/presentations/cloud_icons.dart';

class Mid_Menu extends StatelessWidget {

  String wind,humidity,status;
  Mid_Menu({
    @required this.wind,
    @required this.humidity,
    @required this.status,
});
  @override
  Widget _MenuIcons(IconData icons,String string,String pressure){
    return Container(
      //color: Colors.red,
      alignment: Alignment.topLeft,
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Icon(icons),
              new Padding(padding: EdgeInsets.all(6.0)),
              new Text(pressure==null?'':pressure,
                style: new TextStyle(
                    fontSize: 22.0
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left:12.0),
            child: new Align(
              alignment: Alignment.topLeft,
              child : Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: new Text(string==null?'':string,
                  style: new TextStyle(
                      fontSize: 23.0
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


   @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: Alignment.center,
      child: new Padding(
        padding: EdgeInsets.only(left: 56.0,right: 34.0,top: 48.0),
        child: Container(
          //color: Colors.red,
          width: 350,
          height: 600,
          child: new Column(
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 70.0,top: 56.0,bottom: 25.0),
                  child: _MenuIcons(Cloud.cloud,'',status),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 140.0,top: 56.0,bottom: 25.0),
                  child: _MenuIcons(MyFlutterApp.windmill,wind,'Wind'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 135.0,top: 56.0,bottom: 25.0),
                  child: _MenuIcons(Icons.ac_unit,'','Pressure'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70.0,top: 56.0),
                  child: _MenuIcons(Humidity.humidity,humidity,'Humidity'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


