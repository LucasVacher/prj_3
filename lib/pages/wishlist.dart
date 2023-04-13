import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';


Future<void> Wish() async {
  // Initialisez Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Récupérez l'utilisateur actuellement connecté
  User? user = FirebaseAuth.instance.currentUser;
  String uid = user!.uid;

  // Enregistrez l'UID de l'utilisateur dans votre base de données Realtime Database Firebase
  DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference().child('users');
  databaseReference.child(uid).set({'uid': uid});

  // Utilisez l'UID récupéré pour effectuer des opérations dans votre application
  print("L'UID de l'utilisateur connecté est : $uid");
}