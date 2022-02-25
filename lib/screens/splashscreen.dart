import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage_app/screens/adminscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'user';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkRole();
  }

  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('user')
        .doc(user!.uid)
        .get();
    setState(() {
      role = snap['role'];
    });

    if (role == 'user') {
      //TODO Change to User HomeScreen
      navigateNext(HomeScreen());
    } else if (role == 'admin') {
      navigateNext(AdminScreen());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
          Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => route));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Welcome to FanPage'),
            Image(
              image: AssetImage('assets/HeadShot.JPEG'),
            )
          ],
        ),
      ),
    );
  }
}
