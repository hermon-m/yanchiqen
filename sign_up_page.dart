import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_buttons.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String emailOrPhone = '';

  @override
  Widget build(BuildContext context) {
    String fullName = '';
    String password = '';

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          children: [
            Image.asset('assets/yanchiqen_logo.png', width: 90),
            SizedBox(height: 16),
            Text("Create a new account",
                style: TextStyle(fontSize: 22, color: Colors.pink[700], fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Fill the form below to create a new account.", style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Full Name",
                    onChanged: (val) => fullName = val,
                  ),
                  SizedBox(height: 14),
                  CustomTextField(
                    hintText: "Username",
                    onChanged: (val) => username = val,
                  ),
                  SizedBox(height: 14),
                  CustomTextField(
                    hintText: "Email / Phone Number",
                    onChanged: (val) => emailOrPhone = val,
                  ),
                  SizedBox(height: 14),
                  CustomTextField(
                    hintText: "Password",
                    isPassword: true,
                    onChanged: (val) => password = val,
                  ),
                  SizedBox(height: 20),
                  SocialButtons(google: true, apple: true),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[200],
                      shape: StadiumBorder(),
                      minimumSize: Size(double.infinity, 44),
                    ),
                    child: Text('Sign Up', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, '/verification',
                            arguments: {'emailOrPhone': emailOrPhone, 'username': username});
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacementNamed(context, '/signin'),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Sign In!",
                            style: TextStyle(
                                color: Colors.pink[700],
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}