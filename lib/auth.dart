/*import 'package:firebase_auth/firebase_auth.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future googleSingIn() async{
    try
        {
        AuthResult result = await _auth.signInAnonymously();
        FirebaseUser user = result.user;
        return user;
        }catch(e){
      print(e.toString());
      return null;

    }
  }
}*/
import 'dart:async';

import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();







Future<bool> signInWithGoogle() async {

  BuildContext context;
  print("INICIALIZANDO LOGIN COM GOOGLE...");

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);
  assert(authResult.user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  final FirebaseUser currentUser = await _auth.currentUser;
  assert(user.uid == currentUser.uid);


  Controller controller = Get.find();

  controller.name(user.displayName);
  controller.email(authResult.user.email);
  controller.imageUrl(user.photoURL);

  print(controller.email.value);
  print(controller.name.value);
  print(controller.imageUrl.value);


  /*if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }*/

  //signedIn= LoginInfo.of(context).signed;
  controller.signedIn(true);

  print(controller.signedIn.value);
  return true;
}

Future<void> signOutGoogle() async{
  await googleSignIn.signOut();
  Controller controller = Get.find();
  controller.signedIn(false);
  print(controller.signedIn.value);
  print("User Sign Out");
}



