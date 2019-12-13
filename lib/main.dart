import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reflectly_flutter_loginpage/delayed_animation.dart';
import 'package:reflectly_flutter_loginpage/login.dart';


void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    final color = Colors.white;
    _scale = 1 - _controller.value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black54,
          body: Container(
            margin: new EdgeInsets.symmetric(vertical: 100.0),
            alignment:Alignment.topCenter,
            child: Column(
              children: <Widget>[
                AvatarGlow(
                  endRadius: 100,
                  duration: Duration(seconds: 2),
                  glowColor: Colors.white,
                  repeat: true,
                  repeatPauseDuration: Duration(seconds: 1),
                  startDelay: Duration(seconds: 1),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(

                        child: Material(
                            elevation: 8.0,
                            shape: CircleBorder(),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              child: LogoImageAsset(),
                              radius: 100.0,
                            )),)
                  ),
                ),

                DelayedAnimation(
                  child: Text(
                    "Bonjour !",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 1000,
                ),
                DelayedAnimation(
                  child: Text(
                    "Makrem HAMANI",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.0,
                        color: color),
                  ),
                  delay: delayedAmount + 2000,
                ),
                SizedBox(
                  height: 30.0,
                ),

                SizedBox(
                  height: 50.0,
                ),
                DelayedAnimation(
                  child: LoginButton(),
                  delay: delayedAmount + 4000,
                ),
                SizedBox(height: 50.0,),

              ],
            ),
          )
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
        //     SizedBox(
        //       height: 20.0,
        //     ),
        //      Center(

        //   ),
        //   ],

        // ),
      ),
    );
  }

  Future navigateToSubPage(context) async {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Login();
    }));
  }


}


class LogoImageAsset extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(image: assetImage,width: 1000, height: 80,);
    return Container(child: image,);
  }

}

class LoginButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        onPressed: (){
          openLogin(context);
        },
        color: Colors.white,
        textColor: Colors.black,
        label: Text("Login"),
        icon: Icon(
            Icons.arrow_forward
        ),
      ),
    );
  }

  void openLogin(BuildContext context){
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Login();
    }));
  }
}
