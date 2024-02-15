
import 'package:book_room/admin_panel/admin_firebase.dart/room_method.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminLoginMethod{

final FirebaseAuth _auth=FirebaseAuth.instance;

Future<bool> AdminLogin(
    String email,
    String password,
  ) 
  async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await RoomMethod().CreateDataBase();
      return true;

    } catch (e) {
      debugPrint("Error in admin login function: $e");
      return false;
    }
  }
}


