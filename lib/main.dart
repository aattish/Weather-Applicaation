import 'package:flutter/material.dart';
import 'package:waether_application/fetchData/datacalling.dart';
import 'package:waether_application/background/MainAppBar.dart';
import 'package:waether_application/background/MainPage.dart';
import 'package:waether_application/background/WeekDrawer.dart';
import 'package:waether_application/background/sliding_drawer.dart';
import 'package:intl/intl.dart';

/// Main Function Running Whole Flutter Code
void main() => runApp(MyApp()

);

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(),
    );
  }
}

/// Create the StatefulWidget so that we keep track of state
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  OpenableController openableController;
  FetchData fetchData;
  double _temp;
  static var now = new DateTime.now();
  String formattedDate = DateFormat('EEEE d MMMM').format(now),_status,_wind,_humidity,_city,_mintemp,_maxtemp;
  @override
  void initState() {
    super.initState();
    Fetch().getWeather().then((onValue)=>setState((){
      fetchData=onValue;
      _temp=fetchData.temp;
      _status=fetchData.description;
      _maxtemp=fetchData.maxTemp.toStringAsFixed(2);
      _mintemp=fetchData.minTemp.toStringAsFixed(2);
      _wind=fetchData.wind;
      _city=fetchData.city;
      _humidity=fetchData.humidity;
    }));
    openableController = new OpenableController(
        vsync: this, openDuration: const Duration(milliseconds: 250))
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new MainPage(
            temperature: _temp,
            status: _status,
            wind: _wind,
            humidity: _humidity,
            maxTemp: _maxtemp,
            minTemp: _mintemp,

          ),
          //new TheAppBar(),
          new MainAppBar(
            selectDay: formattedDate,
            onDrawerArrowTap: openableController.open,
            city: _city,
          ),
          new SlidingDrawer(
            openableController: openableController,
            drawer: new WeekDrawer(
              onDaySelected: (title) {
                formattedDate = title;
                openableController.close();
              },
            ),
          ),
        ],
      ),
    );
  }
  

  
}
