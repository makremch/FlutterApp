import 'package:flutter/material.dart';
import 'package:reflectly_flutter_loginpage/models/Product.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  Product _product;
  DetailPage(Product product) {
    _product = product;
  }

  @override
  _DetailPageState createState() => _DetailPageState(_product);
}

class _DetailPageState extends State<DetailPage> {
  Product product;

  _DetailPageState(Product product) {
    this.product = product;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(product.titre),

      ),

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Hero(
                transitionOnUserGestures: true,
                tag: product,
                child: Transform.scale(
                  scale: 2.0,
                  child: Image.asset(product.cover, ),
                ),
              ),
              Row(

                children: <Widget>[
                  Expanded(
                    child:
                      Card(
                          margin: EdgeInsets.all(16),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text(product.description),
                          )
                      ),
                  ),
                  Expanded(
                    child:
                    Card(
                        margin: EdgeInsets.all(16),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Text(product.prix),
                        )
                    ),
                  )

                ],
              )
            ],
          )),
    );
  }
}

