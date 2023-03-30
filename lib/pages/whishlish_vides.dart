import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:prj_3/widgets/widget.dart';

class Wishlist_vides extends StatefulWidget {
  const Wishlist_vides({Key? key}) : super(key: key);

  @override
  State<Wishlist_vides> createState() => _Wishlist_videsState();
}

class _Wishlist_videsState extends State<Wishlist_vides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_1,
        title: Text('Ma liste de souhaits'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: color_1,
        child: Center(
          child: Image(
            image: AssetImage('assets/image/logo_whishlist_vides.png'), // Chemin de l'image dans votre dossier "assets"
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
