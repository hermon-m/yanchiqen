import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  final bool google;
  final bool apple;

  const SocialButtons({this.google = false, this.apple = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (google)
          GestureDetector(
            onTap: () {}, // Integrate or mock Google sign-in
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey[300]!),
                color: Colors.white,
              ),
              child: Image.asset('assets/google_icon.png', width: 28, height: 28, fit: BoxFit.contain),
            ),
          ),
        if (apple)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300]!),
              color: Colors.white,
            ),
            child: Image.asset('assets/apple_icon.png', width: 28, height: 28, fit: BoxFit.contain),
          ),
      ],
    );
  }
}