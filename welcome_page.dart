import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/welcome_bg.jpg', // Your image of 3 women
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.white.withOpacity(0.7),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset('assets/yanchiqen_logo.png', width: 100),
              SizedBox(height: 24),
              Text(
                "Welcome To Yanchiqen",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.pink[700],
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: 220,
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[200],
                        shape: StadiumBorder(),
                        minimumSize: Size(double.infinity, 44),
                      ),
                      child: Text('Sign In', style: TextStyle(color: Colors.black)),
                      onPressed: () => Navigator.pushNamed(context, '/signin'),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[100],
                        shape: StadiumBorder(),
                        minimumSize: Size(double.infinity, 44),
                      ),
                      child: Text('Sign Up', style: TextStyle(color: Colors.black)),
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}