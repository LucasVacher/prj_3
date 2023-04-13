import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String name;
  final String detailed_description;
  final String header_image;


  const ProductDetailsPage({
    Key? key,
    required this.name,
    required this.detailed_description,
    required this.header_image,
  }) : super(key: key);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _isFavorited = false;
  bool _isStarred = false;

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true,
    );

    return htmlText.replaceAll(exp, '');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A2026),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A2026),
        title: Text('Détail du jeu'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              child: _isFavorited
                  ? Icon(Icons.favorite, color: Colors.white)
                  : Icon(Icons.favorite_border_outlined, color: Colors.white),
              onTap: () {
                setState(() {
                  _isFavorited = !_isFavorited;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              child: _isStarred
                  ? Icon(Icons.star, color: Colors.white)
                  : Icon(Icons.star_border_outlined, color: Colors.white),
              onTap: () {
                setState(() {
                  _isStarred = !_isStarred;
                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.header_image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Image.network(
                    widget.header_image,
                    width: 100,
                    height: 100,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Nom du jeu : ${widget.name}',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description : ${removeAllHtmlTags(widget.detailed_description)}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}