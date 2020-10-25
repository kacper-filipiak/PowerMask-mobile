import 'SignedInPage.dart';
import 'package:powermaskmobile/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth.dart';


class LoginPage extends StatelessWidget {

  Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        backgroundColor: Color.fromARGB(50, 50, 50, 50),
        body: Stack(
          children: [
            Flexible(child: FlatButton(onPressed:()=> Get.back(), child: Container(),)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Icon(Icons.account_circle,size: 100,),
                      SizedBox(height: 50),
                  OutlineButton(
                    splashColor: Colors.grey,
                    onPressed:()=> googleSignIn.signIn().whenComplete(() {
                      Get.off(SignedInPage());
                      processMap();
                    }),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.grey),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.account_circle,size: 50,),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                      //BackButton(onPressed: ()=> Navigator.pop(context),),
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



