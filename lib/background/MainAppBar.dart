//Importing package
import 'package:flutter/material.dart';
import 'package:waether_application/fetchData/datacalling.dart';
import 'package:waether_application/background/spintext.dart';

/// Creating the appbar for application
class MainAppBar extends StatelessWidget {
  //Initializing all variable and function
  final Function onDrawerArrowTap;
  final String selectDay,city;
  MainAppBar({
    this.onDrawerArrowTap,
    this.selectDay,
    this.city,
  });


  /// Position the appBar and Creating Appbar
  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top : 0.0,
        left: 0.0,
        right: 0.0,
        child: new AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new SpinnerText(text: selectDay,),
              new Text(city==null?'':city,
                style: new TextStyle(color: Colors.white,
                    fontSize: 28.0),
              )
            ],
          ),
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.my_location),
                color: Colors.greenAccent,
                onPressed: ()
                {
                    print(new Fetch().getWeather());
                    //print(FetchData.temp);
            },
                iconSize: 30.0),
            new IconButton(
                icon: new Icon(Icons.arrow_forward_ios),
                onPressed: onDrawerArrowTap,
                color: Colors.greenAccent,
                iconSize: 35.0
            )
          ],
        )
    );
  }
}


