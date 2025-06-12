import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_buttons.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String username = '';

  @override
  Widget build(BuildContext context) {
    String emailOrPhone = '';
    String password = '';
    bool obscure = true;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
        child: Column(
          children: [
            Image.asset('assets/yanchiqen_logo.png', width: 90),
            SizedBox(height: 16),
            Text("Welcome Back",
                style: TextStyle(fontSize: 22, color: Colors.pink[700], fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Please, Sign In.", style: TextStyle(color: Colors.grey[600])),
            SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Email/Phone/Username",
                    onChanged: (val) => emailOrPhone = val,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    hintText: "Password",
                    isPassword: true,
                    onChanged: (val) => password = val,
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[200],
                      shape: StadiumBorder(),
                      minimumSize: Size(double.infinity, 44),
                    ),
                    child: Text('Sign In', style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Mock: extract username
                        String uname = emailOrPhone.split('@').first;
                        Navigator.pushReplacementNamed(context, '/start',
                            arguments: {'username': uname});
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text("Forgot password?", style: TextStyle(color: Colors.grey[700])),
                        onPressed: () {},
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, '/signup'),
                        child: RichText(
                          text: TextSpan(
                            text: "New here? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sign Up",
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
                  SizedBox(height: 28),
                  SocialButtons(google: true, apple: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}