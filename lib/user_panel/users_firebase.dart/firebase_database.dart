
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class DataBaseClass{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  
  Future addUser(String name, String contactNumber,String mail,String password)async{
   
  try{
    String uid=  _auth.currentUser!.uid;
    UserModel user=UserModel(
      bookedRooms: [],
      password: password,
      userId: uid , 
      name: name,
      mail: mail,
      contactNumber: contactNumber
        );

       _firestore.collection("users").doc(uid).set(user.toJson());
  }
 
  catch(e){
   debugPrint("error in add user function error=> $e");
   
  }
  }
   
}