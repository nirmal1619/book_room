import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'booking_screen.dart';
import 'login_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _authStateChange=false;

  @override
  void initState() {
    super.initState();
  checkState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 100.0,
      end: 200.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => _authStateChange ? BookingScreen( ) : LogInScreen()),
      ),
    );
  }

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Center(
          child: Icon(
            Icons.home,
            size: _animation.value,
            // width: ,
            // height: _animation.value,
            ),
        
        ),
      ),
    );
  }
}


