import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




Future<QuerySnapshot> searchStream ([String _document, String _fild = null, _conditionData = null,String _path = "/users"])  async {
  await Firebase.initializeApp();

  return FirebaseFirestore.instance.collection("users").doc("104549409855956791484").collection("sessions").get();
}
void addData(String _name, GeoPoint _localization, String _organizator, String _description, DateTime _time,[String _path = "/events"]){

  Firestore.instance.collection(_path).add({'name': _name, 'localization': _localization, 'organizator': _organizator, 'description': _description, 'time': _time});
}