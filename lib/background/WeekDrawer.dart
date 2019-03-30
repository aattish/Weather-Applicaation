import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekDrawer extends StatelessWidget {
  static var date = new DateTime.now();

  static var week1 = new DateTime(date.year, date.month, date.day+ 1);
  static String Date1 = DateFormat('EEEE d MMMM').format(week1);

  static var week2 = new DateTime(date.year, date.month, date.day + 2);
  static String Date2 = DateFormat('EEEE d MMMM').format(week2);

  static var week3 = new DateTime(date.year, date.month, date.day + 3);
  static String Date3 = DateFormat('EEEE d MMMM').format(week3);

  static var week4 = new DateTime(date.year, date.month, date.day + 4);
  static String Date4 = DateFormat('EEEE d MMMM').format(week4);

  static var week5 = new DateTime(date.year, date.month, date.day + 5);
  static String Date5 = DateFormat('EEEE d MMMM').format(week5);

  static var week6 = new DateTime(date.year, date.month, date.day + 6);
  static String Date6 = DateFormat('EEEE d MMMM').format(week6);

  static var week7 = new DateTime(date.year, date.month, date.day + 7);
  static String Date7 = DateFormat('EEEE d MMMM').format(week7);


  final week=[
    Date1,
    Date2,
    Date3,
    Date4,
    Date5,
    Date6,
    Date7,
  ];


  final Function(String title) onDaySelected;

  WeekDrawer({
   this.onDaySelected,

});

  List<Widget> _listOfDay(){
    return week.map((String title){
      return new Expanded(
          child: new GestureDetector(
            onTap: (){onDaySelected(title);},
            child: new Text(
              title,
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          )
      );
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      color: new Color(0x2A234070),
      width: 125.0,
      height: double.infinity,
      child: new Column(
        children: <Widget>[
         ]..addAll(_listOfDay()),
      ),
    );
  }
}
