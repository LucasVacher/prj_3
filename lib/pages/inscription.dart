import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:prj_3/pages/connexion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prj_3/widgets/widget.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Inscription extends StatefulWidget {
  const Inscription({super.key});
  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _handleLogin() {
    // Connecter l'utilisateur

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Texte Bienvenue
              Text(
                'Inscri',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Veuillez saisir ces différentes informations, \n afin que vos listes soient sauvegardées.',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10),

              TextField(
                controller: _usernameController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Nom d utilisateur',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                obscureText: true,
              ),

              SizedBox(height: 10),

              TextField(
                controller: _emailController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'E-mail',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                obscureText: false,
              ),

              SizedBox(height: 10),

              TextField(
                controller: _passwordController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                obscureText: true,
              ),

              SizedBox(height: 10),


              TextField(
                controller: _confirmPasswordController,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Vérification du mot de passe',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                obscureText: true,
              ),


              SizedBox(height: 80),

              signInSignUpButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Connexion()));
                }).catchError((dynamic error){
                  if (error.code.contains('invalid-email')) {
                    _buildErrorMessage("Mail invalid");
                  }
                  if (error.code.contains('user-not-found')) {
                    _buildErrorMessage("utilisateur inconnu. Créer un compte");
                  }
                  if (error.code.contains('weak-password')) {
                    _buildErrorMessage("Mot de passe trop court");
                  }
                }
                );
              })
            ],
          ),
        ),
      ),
    );
  }
  void _buildErrorMessage(String text) {
    Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.red,
        fontSize: 20);
  }
}
