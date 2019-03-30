import 'package:flutter/material.dart';
import 'package:waether_application/background/Rain.dart';
import 'package:waether_application/background/Sunny.dart';

class BackGroundWithRings extends StatelessWidget{

  String daytime,status;
  BackGroundWithRings({
     @required this.daytime,
     @required this.status
});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          daytime=='Day'?(status=='Clear')?Image.asset('images/blue-sky.jpg',fit: BoxFit.cover,):Image.asset('images/clouds2.jpg',fit: BoxFit.cover,):status=='Clear'?Image.asset('images/weather-bk_enlarged.png',fit: BoxFit.cover,):Image.asset('images/weather-bk_enlarged.png',fit: BoxFit.cover,),
    new ClipOval(
            clipper: CirlceClipper(
                radius: 140.0,
                offset: const Offset(40.0, 0.0)
            ),
            child: daytime=='Day'?(status=='Clear')?Image.asset('images/blue-sky.jpg',fit: BoxFit.cover,):Image.asset('images/cloudy.jpg',fit: BoxFit.cover,):status=='Clear'?Image.asset('images/cloudy.gif',fit: BoxFit.cover,):Image.asset('images/weather-bk.png',fit: BoxFit.cover,),
          ),
          Sunny(),
        ],
      ),
    );
  }
}


class CirlceClipper extends CustomClipper<Rect>{

  final double radius;
  final Offset offset;

  CirlceClipper({
    this.radius,
    this.offset=const Offset(0.0, 0.0)
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: new Offset(0.0, size.height/2)+offset,
        radius: radius
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

