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


Future<List<int>> getAllProducts() async {
  var response = await http.get(Uri.parse(
      "https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List<dynamic> listData = data['response']['ranks'];
    final List<int> ListID =
    List<int>.from(listData.map((data) => data['appid'] as int));

    return ListID;
  } else {
    throw Exception('échec chargement ID');
  }
}

Future<Map<String, dynamic>> getProductDetails(int productId) async {
  var response = await http.get(Uri.parse(
      "https://store.steampowered.com/api/appdetails?appids=$productId"));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final details = data['$productId']['data'];

    if (details != null) {
      return details;
    } else {
      throw Exception('Détails indisponibles pour ID : $productId');
    }
  } else {
    throw Exception('échec chargement des détails pour ID : $productId');
  }
}

Future<List<Map<String, dynamic>>> getAllProductDetails() async {
  final ids = await getAllProducts();
  final List<Map<String, dynamic>> productDetails = [];

  for (final id in ids) {
    try {
      final details = await getProductDetails(id);
      final name = details['name'];
      final headerImage = details['header_image'];
      final publishers = details['publishers'];
      final isFree = details['is_free'];
      productDetails.add({
        'name': name,
        'header_image': headerImage,
        'publishers': publishers,
        'is_free': isFree,
      });
    } catch (e) {
      print(e);
      // Continuer avec le produit suivant en cas d'erreur.
      continue;
    }
  }

  return productDetails;
}



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Map<String, dynamic>>> _futureProductDetails = Future.value([]);

  @override
  void initState() {
    super.initState();
    _futureProductDetails = getAllProductDetails();
  }
  String getPrice(Map<String, dynamic>? details) {
    final isFree = details?['is_free'] ?? false;
    if (isFree) {
      return 'Free';
    } else {
      final jsonResponse2 = details?['price_overview'];
      String price;
      if (jsonResponse2 != null) {
        //Si le prix du jeu est correctement renseigné
        if(jsonResponse2['initial_formatted'] != "")
        {
          //On récupère le prix initial (avant réduction)
          price = jsonResponse2['initial_formatted'];
        } else {
          //Sinon on récupère le prix final
          price = jsonResponse2['final_formatted'] ?? jsonResponse2['initial_formatted'];
        }
      } else {
        //Sinon on le met gratuit
        price = "pas possible";
      }
      return price;
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF1A2026),
        appBar: AppBar(
          backgroundColor: Color(0xFF1A2026),
          title: Text('Accueil'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.star_border_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
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
                                  'Publishers: ${details?['publishers']?.join(', ') ?? ''}',
                                  style: TextStyle(fontSize: 16,color: Colors.white,),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Free: ${details?['is_free'] ? 'Yes' : 'No'}',
                                  style: TextStyle(fontSize: 16,color: Colors.white,),
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

      ),
    );
  }
}
