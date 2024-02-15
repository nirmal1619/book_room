import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class FirebaseAuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> createAccount(
    String email,
    String password,
  ) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return "successful";
    } catch (e) {
      debugPrint(e.toString());
      return "unsuccessful";
    }
  }

  Future<bool> logIn(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      debugPrint("Error in login function: $e");
      return false;
    }
  }

  Future<UserModel> getUserDetails(String uid)async{
      UserModel userDetailsNull=UserModel(userId:uid, name: "", mail:" ", contactNumber: "", password: "", bookedRooms: []);
     try{


      DocumentSnapshot snap=await FirebaseFirestore.instance.collection("users").doc(uid).get();
      UserModel userDetails= UserModel.fromJson(snap);
      return userDetails;
     }
     catch(e){
       
     }
  return userDetailsNull;
  }
  SignOut()async{
   await _auth.signOut();
  }


}
