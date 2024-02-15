
import 'package:book_room/admin_panel/screens/admin_login_Screen.dart';
import 'package:book_room/admin_panel/screens/admin_panel_screen.dart';
import 'package:book_room/user_panel/screens/booking_screen.dart';
import 'package:book_room/user_panel/screens/login_screen.dart';
import 'package:book_room/user_panel/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _authStateChange=false;
  void checkState(){
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      setState(() {
        _authStateChange=false;
      });
    } else {setState(() {
        _authStateChange=true;
      });
      print('User is signed in!');
    }
  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BookingScreen(),
    );
  }
}