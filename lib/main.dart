import 'dart:math';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pick A Card- AnyCard',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _backImage = 'assets/back.jpg';
  String _suit = '';
  String _power ='';
  Color _powerColor = Colors.black;
  //BC2025 red
  var powerList = ['K','Q','J', 'A', '2', '3', '4', '5', '6', '7', '8', '9'];
  var suitList = ['assets/clubs.png','assets/spades.png','assets/diamonds.png', 'assets/hearts.png',];

  void _tapOnCard() {
    setState(() {
      _makeTapNoise();
      if (_backImage != 'assets/back.jpg') {
        _backImage = 'assets/back.jpg';
        _power = '';
        _suit = '';
      } else {
        _backImage = '';
        _swipeCard();
      }
    });
  }

  void _swipeCard() {
    setState(() {
      if (_backImage != 'assets/back.jpg') {
        _generateRandomCard();
      }
    });
  }

  void _generateRandomCard() {
    print("swipe works");
    //todo put sound
    _power = getRandomElement(powerList);
    _suit = getRandomElement(suitList);
    if(_suit == 'assets/hearts.png' || _suit == 'assets/diamonds.png') {
      _powerColor = colorFromHex('bc2025');
    } else {
      _powerColor = Colors.black;
    }
  }

  Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  T getRandomElement<T>(List<T> list) {
    final random = new Random();
    var i = random.nextInt(list.length);
    return list[i];
  }

  void _makeTapNoise() {
    print("tap works");

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child:
          SwipeDetector(
            onSwipeRight: _swipeCard,
            onSwipeLeft: _swipeCard,
            child: GestureDetector(
              onTap: _tapOnCard,
              /*onPanUpdate: (details) {
                if (details.delta.dx > 0) {
                  // swiping in right direction
                  _swipeCard();
                }
                if (details.delta.dx < 0) {
                  // swiping in left direction
                  _swipeCard();
                }
              },*/
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(_backImage),

                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(.95,.69),
                      child: Image(
                        image: AssetImage(_suit),
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Align(
                      alignment: Alignment(-.8,-.69),
                      child: Text(
                        '$_power',
                        style: TextStyle(
                          fontSize: 150,
                          color: _powerColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}
