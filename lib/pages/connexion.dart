import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';
import 'package:prj_3/pages/accueil.dart';
import 'package:prj_3/pages/inscription.dart';
import 'package:prj_3/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

              SizedBox(height: 100),

              // Texte Bienvenue
              Text(
                'Bienvenue 10 !',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 25),

              Text(
                'Veuillez vous connecter ou\n créer un nouveau compte\n pour utiliser l\'application.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 35),

              TextField(
                controller: _usernameController,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
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

              SizedBox(height: 15),

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

              SizedBox(height: 80),

              signInSignUpButton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: _usernameController.text,
                    password: _passwordController.text)
                    .then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (contxte) => Accueil()));
                }).catchError((dynamic error){
                  if (error.code.contains('invalid-email')) {
                    _buildErrorMessage("Mail invalid");
                  }
                  if (error.code.contains('user-not-found')) {
                    _buildErrorMessage("utilisateur inconnu. Créer un compte");
                  }
                  if (error.code.contains('wrong-password')) {
                    _buildErrorMessage("Mot de passeincorrect");
                  }
                }
                );
              }),


              SizedBox(height: 10),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal:90, vertical:20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: color_2),
                  ),
                  textStyle: TextStyle(color: Colors.white),
                ),
                child: Text('Créer un nouveau compte'),
                onPressed: (){
                  Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context)=>Inscription()),
                  );
                },
              ),


              SizedBox(height: 100),

              /*Text(
                'Mot de passe oublié',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.center,
              ),*/

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
