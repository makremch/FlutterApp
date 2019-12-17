import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:reflectly_flutter_loginpage/details_article.dart';
import 'package:reflectly_flutter_loginpage/models/Product.dart';
import 'package:reflectly_flutter_loginpage/login.dart';

class ListeArticles extends StatelessWidget {
  List<Product> produits=[] ;

  ListeArticles(List produits) {
    this.produits = produits.map( (pr) => Product(
        titre: pr["titre"] ,
        description: pr["description"] ,
        prix: pr["prix"],
        img : "images/"  + pr["titre"].replaceAll(" ","").toLowerCase() + ".png",
        cover : "images/"  + pr["titre"].replaceAll(" ","").toLowerCase() + "cover.jpg",
    ) ).toList();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black,
        primarySwatch: Colors.grey,
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


class _ProductsPageState extends State<ProductsPage> {
  List<Product>items  ;
  List<Product> visibleItems  ;

  _ProductsPageState(List<Product> items ) {
    this.items = items ;
    this.visibleItems = items ;
  }

  Widget ProductCell(BuildContext ctx, int index) {

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
          return DetailPage(visibleItems[index]);
        }));
      },
      child:  Card( //
        margin: EdgeInsets.all(10),
        elevation: 4.0,
        child: ListTile(
          leading: Image.asset(visibleItems[index].img),
          title: Text(visibleItems[index].titre),
          subtitle: Text(visibleItems[index].description + "  |  " + visibleItems[index].prix ),
        ),
      )
    );
  }

  _onQueryChanged(BuildContext context, String query) {
    query = query.trim() ;
    if(query=="") {
      setState(() => visibleItems = items) ;
    }
    else setState(() =>  visibleItems = items.where((i) => i.description.contains(query)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchBar(
        searchHint : "Cherchez un produit 🔍",
        defaultBar: AppBar(

          leading: IconButton(
            icon: Icon(Icons.power_settings_new), onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return new Login();
            }));
            },
          ),
          title: Text('Liste des produits'),
        ),
        onQueryChanged: (query) => _onQueryChanged(context, query),
      ),
      body: Center(

        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: visibleItems.length,
              itemBuilder: (context, index) => ProductCell(context, index ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}