import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:reflectly_flutter_loginpage/liste_articles.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: InputEmailText()
    );
  }
}

class InputEmailText extends StatefulWidget {
  @override
  MyInputEmailTextState  createState() { return MyInputEmailTextState() ; }
}

class MyInputEmailTextState extends State<InputEmailText>{

  String username = "";
  String pwd = "";
  bool _emailIsValid = false ;
  bool _emailIsEmpty = true ;
  final double number = 2.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to Flutter",
        home: SingleChildScrollView(
            child: new Material(
            child: new Container (
                padding: const EdgeInsets.all(30.0),
                color: Colors.white10,
                child: new Container(
                  margin: new EdgeInsets.symmetric(vertical: 20.0),
                  child: new Center(
                      child: new Column(
                          children : [

                            new Image(image:  AssetImage('images/logo.png'),width: 1000, height: 80,),

                            new Padding(padding: EdgeInsets.only(top: 90.0)),

                            new TextFormField(
                              onChanged: (str) {
                                setState(() {
                                  _emailIsEmpty =  (str.length == 0 ) ;
                                  _emailIsValid = isEmail(str) ;
                                });
                              },
                              decoration: new InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.blueGrey,
                                ),
                                suffixIcon: _emailIsEmpty ? null : (_emailIsValid ? const Icon(Icons.check,
                                  color: Colors.green,) : const Icon(Icons.close,
                                  color: Colors.red,)),
                                labelText: "Enter Email",
                                helperText: "",
                                helperStyle: new TextStyle(color: Colors.white),
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.red
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if(val.length==0) {
                                  return "Email cannot be empty";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),

                            new TextFormField(
                              onChanged: (String str){

                                pwd = str;
                                },
                              obscureText: true,
                              decoration: new InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.blueGrey,
                                ),
                                labelText: "Enter Password",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {
                                if(val.length==0) {
                                  return "Email cannot be empty";
                                }else{
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                            new Padding(padding: EdgeInsets.only(top: 20.0)),
                            ProgressButton(
                              borderRadius: 20.0,
                              defaultWidget: const Text('Login'),
                              progressWidget: const CircularProgressIndicator(),
                              width: 800,
                              height: 40,
                              color: Colors.blueAccent,
                              onPressed: () async {
                                int score = await Future.delayed(
                                    const Duration(milliseconds: 3000), () => 42);
                                return () {
                                  doLogin(pwd, username);
                                };
                              },
                            ),
                          ]
                      )
                  ),
                )
            )
        ))
    );
  }

  void doLogin(String pwd , String username) async{

    username = "makrem.hamani@esprit.tn" ;
    pwd = "SMICtest" ;
    String url = 'http://siniway.com/Stage/connexion.php';
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = pwd;

    Response response = await post(
      url,
      body: map,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print(res) ;

      if(res["status"]!="OK") {
        print(222) ;
        print("Cannot connect") ;
        showDialog(
            context: context,
            builder: (BuildContext context){
              return  AlertDialog(
                title: Text("Authentication"),
                content: Text("Wrong username & password "),
              );
            }
        );
      }

      else if (res["message"]=="Not found"){
        showDialog(
            context: context,
            builder: (BuildContext context){
              return  AlertDialog(
                title: Text("Authentication"),
                content: Text("Wrong E-mail"),
              );
            }
        );
      } else {
       Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return ListeArticles(res["produits"]);
        }));
      }


    } else {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return  AlertDialog(

              title: Text("Error Network"),
              content: Text("Check your internet connection ! "),
            );
          }
      );    }
  }

  bool isEmail(String em) {
    if(em.length==0) return false;
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

}


