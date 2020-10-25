//import 'dart:html';

import 'LoginPage.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth.dart';


Widget userDataDisplay(String label,String value){
  return Column(
    children:[
    Text(
    label,
    style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black54),
  ),
  Text(
    value,
    style: TextStyle(
          fontSize: 20,
          color: Colors.grey,

    fontWeight: FontWeight.bold),
  ),]
  );
}

class SignedInPage extends StatelessWidget {
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromARGB(50, 50, 50, 50),
      body: Stack(
        children: [
          Expanded(child: FlatButton(onPressed: () => Get.back(), child: Container())),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircleAvatar(
                     backgroundImage: NetworkImage(
                       googleSignIn.currentUser.photoUrl==null||googleSignIn.currentUser.photoUrl==""?"https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Ic_account_circle_48px.svg/600px-Ic_account_circle_48px.svg.png":googleSignIn.currentUser.photoUrl,
                     ),
                      radius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(height: 40),
                    userDataDisplay("NAME", googleSignIn.currentUser.displayName),
                    SizedBox(height: 20),
                    userDataDisplay("EMAIL", googleSignIn.currentUser.email),

                    SizedBox(height: 40),
                    OutlineButton(
                      splashColor: Colors.grey,
                      onPressed:()=> googleSignIn.signOut().whenComplete(() {
                        Get.off(LoginPage());
                      }),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 0,
                      borderSide: BorderSide(color: Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}