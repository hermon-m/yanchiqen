import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    String username = args['username'] ?? 'User';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/yanchiqen_logo.png', width: 120),
            SizedBox(height: 32),
            Text(
              "Welcome to YanchiQen, $username",
              style: TextStyle(fontSize: 22, color: Colors.pink[700], fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}