import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:prj_3/widgets/widget.dart';

class Likes_vides extends StatefulWidget {
  const Likes_vides({Key? key}) : super(key: key);

  @override
  State<Likes_vides> createState() => _Likes_videsState();
}

class _Likes_videsState extends State<Likes_vides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_1,
        title: Text('Mes likes'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: color_1,
        child: Center(
          child: Image(
            image: AssetImage('assets/image/logo_likes_vides.png'), // Chemin de l'image dans votre dossier "assets"
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
