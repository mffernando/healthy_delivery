import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //return user id
  String getUserId() {
    return _firebaseAuth.currentUser!.uid;
  }

  //collections in firestore (Products Reference)
  final CollectionReference productsReference = FirebaseFirestore
      .instance
      .collection("Products");

  //Users Reference
  final CollectionReference usersReference = FirebaseFirestore
      .instance
      .collection("Users");

 }