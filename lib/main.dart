import 'package:flutter/material.dart';
import 'pages/connexion.dart';
import 'package:prj_3/service/api_handler.dart';
import 'classement.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Connexion(),
    );
  }
/*
  @override
  void didChangeDependencies() {
    APIHandler.getAllProducts();
    super.didChangeDependencies();
  }
*/

}



