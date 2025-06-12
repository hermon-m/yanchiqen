import 'package:flutter/material.dart';
import 'dart:async';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/yanchiqen_logo.png',
          width: 180,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}