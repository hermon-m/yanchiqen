import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationPage extends StatefulWidget {
  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String otp = '';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    String emailOrPhone = args['emailOrPhone'] ?? '';
    String username = args['username'] ?? '';

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/yanchiqen_logo.png', width: 90),
            SizedBox(height: 20),
            Text('Verification Code',
                style: TextStyle(fontSize: 22, color: Colors.pink[700], fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              "Please type the verification code sent to your number or email.",
              style: TextStyle(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                inactiveFillColor: Colors.grey[200]!,
                activeColor: Colors.orange,
                selectedColor: Colors.pink[300]!,
                inactiveColor: Colors.grey,
              ),
              animationDuration: Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) => otp = value,
              onCompleted: (value) => otp = value,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[200],
                shape: StadiumBorder(),
                minimumSize: Size(double.infinity, 44),
              ),
              child: Text('Continue', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/cyclesetup', arguments: {'username': username});
              },
            ),
          ],
        ),
      ),
    );
  }
}