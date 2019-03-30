import 'dart:async';
import 'dart:ui' as ui show Image;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spritewidget/spritewidget.dart';

ImageMap _images;

SpriteSheet _sprites;


class Sunny extends StatefulWidget {
  Sunny({ Key key }) : super(key: key);


  @override
  _SunnyState createState() => new _SunnyState();
}


class _SunnyState extends State<Sunny> {

  // This method loads all assets that are needed for the demo.
  Future<Null> _loadAssets(AssetBundle bundle) async {
    // Load images using an ImageMap
    _images = new ImageMap(bundle);
    await _images.load(<String>[
      'images/ray.png',
      'images/sun.png',
      'images/weathersprites.png',
    ]);

    String json = await DefaultAssetBundle.of(context).loadString('images/weathersprites.json');
    _sprites = new SpriteSheet(_images['images/weathersprites.png'], json);
  }

  void initState() {
    // Always call super.initState
    super.initState();

    // Get our root asset bundle
    AssetBundle bundle = rootBundle;

    // Load all graphics, then set the state to assetsLoaded and create the
    // WeatherWorld sprite tree
    _loadAssets(bundle).then((_) {
      setState(() {
        assetsLoaded = true;
        weatherWorld = new WeatherWorld();
      });
    });
  }

  bool assetsLoaded = false;

  // The weather world is our sprite tree that handles the weather
  // animations.
  WeatherWorld weatherWorld;

  Widget build(BuildContext context) {
    return assetsLoaded
        ? new SpriteWidget(weatherWorld)
        : new Container();

  }
}


class WeatherWorld extends NodeWithSize {
  WeatherWorld() : super(const Size(2048.0, 2048.0)) {

    // Add the sun, rain, and snow (which we are going to fade in/out depending
    // on which weather are selected.
    _sun = new Sun();
    _sun.position = const Offset(1024.0, 1024.0);
    _sun.scale = 1.5;
    addChild(_sun);
  }

  Sun _sun;

  @override
  void spriteBoxPerformedLayout() {
    // If the device is rotated or if the size of the SpriteWidget changes we
    // are adjusting the position of the sun.
    _sun.position = spriteBox.visibleArea.topCenter + const Offset(180.0, 180.0);
  }
}
int _kNumSunRays =50;
class Sun extends Node {
  Sun() {
    // Create the sun
    _sun = new Sprite.fromImage(_images['images/sun.png']);
    _sun.scale = 4.0;
    _sun.transferMode = BlendMode.plus;
    addChild(_sun);

    // Create rays
    _rays = <Ray>[];
    for (int i = 0; i < _kNumSunRays; i += 1) {
      Ray ray = new Ray();
      addChild(ray);
      _rays.add(ray);
    }
  }

  Sprite _sun;
  List<Ray> _rays;

  set active(bool active) {
    // Toggle visibility of the sun

    actions.stopAll();

    double targetOpacity;
    if (!active) targetOpacity = 0.0;
    else targetOpacity = 1.0;

    actions.run(
        new ActionTween<double>(
                (a) => _sun.opacity = a,
            _sun.opacity,
            targetOpacity,
            2.0
        )
    );

    if (active) {
      for (Ray ray in _rays) {
        actions.run(new ActionSequence(<Action>[
          new ActionDelay(1.5),
          new ActionTween<double>(
                  (a) => ray.opacity = a,
              ray.opacity,
              ray.maxOpacity,
              1.5
          )
        ]));
      }
    } else {
      for (Ray ray in _rays) {
        actions.run(new ActionTween<double>(
                (a) => ray.opacity = a,
            ray.opacity,
            0.0,
            0.2
        ));
      }
    }
  }
}

// An animated sun ray
class Ray extends Sprite {
  double _rotationSpeed;
  double maxOpacity;

  Ray() : super.fromImage(_images['images/ray.png']) {
    pivot = const Offset(0.0, 0.5);
    transferMode = BlendMode.plus;
    rotation = randomDouble() * 360.0;
    maxOpacity = randomDouble() * 0.2;
    opacity = maxOpacity;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    double scaleTime = randomSignedDouble() * 2.0 + 4.0;

    actions.run(new ActionRepeatForever(
        new ActionSequence(<Action>[
          new ActionTween<double>((a) => scaleX = a, scaleX, scaleX * 0.5, scaleTime),
          new ActionTween<double>((a) => scaleX = a, scaleX * 0.5, scaleX, scaleTime)
        ])
    ));
  }

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}
