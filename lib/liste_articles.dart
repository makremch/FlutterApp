import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:reflectly_flutter_loginpage/login.dart';


class ListeArticles extends StatelessWidget {
  List<Product> produits=[] ;

  ListeArticles(List produits) {
    this.produits = produits.map( (pr) => Product(
        titre: pr["titre"] ,
        description: pr["description"] ,
        prix: pr["prix"],
        img : "images/fraise.png"
    ) ).toList();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductsPage(items: this.produits),
    );
  }
}

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key, this.items}) : super(key: key);


  final List<Product> items  ;

  @override
  _ProductsPageState createState() => _ProductsPageState(this.items);
}

class Product {
  final String titre;
  final String description;
  final String prix;
  final String img;

  Product({this.titre, this.description, this.prix , this.img});
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> items  ;

  _ProductsPageState(List<Product> items ) {
    this.items = items ;
  }

  Widget ProductCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () {
        print(22) ;
      },
      child: Card(
          margin: EdgeInsets.all(8),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img , width: 25,),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      items[index].titre,
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("jhjjj"),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => ProductCell(context, index),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}