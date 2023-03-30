import 'package:flutter/material.dart';
import 'package:prj_3/pages/colors.dart';


Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 7.0),
    height: 50,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'Connexion' : 'Sinscrire',
        style: const TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return color_2;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
    ),
  );
}
