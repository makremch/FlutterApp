import 'package:flutter/material.dart';
import 'package:reflectly_flutter_loginpage/welcome.dart' ;
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';


void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
        home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new AfterSplash(),
        title: new Text(' ',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image(image: AssetImage('images/logo.png'),width: 1000, height: 80,),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Welcome();
  }
}