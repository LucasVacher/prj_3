import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:prj_3/pages/likes_vides.dart';
import 'package:prj_3/pages/whishlish_vides.dart';
import 'package:prj_3/pages/inscription.dart';
import 'package:prj_3/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'accueil.dart';





////////////////////////////







class Recherche extends StatefulWidget {
  @override
  _RechercheState createState() => _RechercheState();
}

class _RechercheState extends State<Recherche> {

  Future<List<Map<String, dynamic>>> _futureProductDetails = Future.value([]);
  List<Map<String, dynamic>> _products = [];



  @override
  void initState() {
    super.initState();
    getAllProductDetails().then((products) {
      setState(() {
        _products = products;
      });
    });
  }

  @override
  String getPrice(Map<String, dynamic>? details) {
    final isFree = details?['is_free'] ?? false;
    if (isFree) {
      return 'Free';
    } else {
      final jsonResponse2 = details?['price_overview'];
      String price;
      if (jsonResponse2 != null) {
        //Si le prix du jeu est correctement renseigné
        if (jsonResponse2['initial_formatted'] != "") {
          //On récupère le prix initial (avant réduction)
          price = jsonResponse2['initial_formatted'];
        } else {
          //Sinon on récupère le prix final
          price = jsonResponse2['final_formatted'] ??
              jsonResponse2['initial_formatted'];
        }
      } else {
        //Sinon on le met gratuit
        price = "pas possible";
      }
      return price;
    }
  }


  @override
  List<Map<String, dynamic>> _filteredProducts = [];

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF1A2026),
        appBar: AppBar(
          backgroundColor: color_1,
          title: Text('Rechercher'),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),


        body:
        Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: 'Rechercher...',

                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  filled: true,
                  fillColor: Color(0xFF1A2026),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8.0),
                  )
              ),
              style: TextStyle(
                  color: Colors.white
              ),


              onChanged: (value) {
                setState(() {
                  _filteredProducts = _products
                      .where((product) =>
                      product['name'].toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return ListTile(
                    leading: Image.network(product['header_image']),
                    title: Text(product['name']),
                    subtitle: Text(product['publishers'][0]),
                    trailing: product['is_free'] ? Text('GRATUIT') : null,
                  );
                },
              ),
            ),

            Center(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _futureProductDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final productDetails = snapshot.data;
                    return ListView.builder(
                      itemCount: productDetails?.length ?? 0,
                      itemBuilder: (context, index) {
                        final details = productDetails?[index];
                        final price = getPrice(details);
                        return Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF2D333D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 100,
                                  child: Image.network(
                                    details?['header_image'] ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      details?['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Publishers: ${details?['publishers']?.join(
                                          ', ') ?? ''}',
                                      style: TextStyle(
                                        fontSize: 16, color: Colors.white,),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Free: ${details?['is_free'] ? 'Yes' : 'No'}',
                                      style: TextStyle(
                                        fontSize: 16, color: Colors.white,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF636AF6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  void search(value) {}
}
class ProductSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [      IconButton(        icon: const Icon(Icons.clear),        onPressed: () {          query = '';        },      )    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    final results = products.where((product) => product['name'].contains(query)).toList();
    if (products.isEmpty) {// c'est censé gérer l'erreur
      return Center(
        child: Text(
          'Aucun résultat trouvé pour "$query".',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: Image.network(product['header_image']),
          title: Text(product['name']),
          subtitle: Text(product['publishers'][0]),
          trailing: product['is_free'] ? Text('GRATUIT') : null,
          onTap: () {
            close(context, product['name']);
          },
        );
      },
    );
  }  @override
  Widget buildSuggestions(BuildContext context) {
    final results = products.where((product) => product['name'].contains(query)).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: Image.network(product['header_image']),
          title: Text(product['name']),
          subtitle: Text(product['publishers'][0]),
          trailing: product['is_free'] ? Text('GRATUIT') : null,
          onTap: () {
            close(context, product['name']);
          },
        );
      },
    );
  }
}



