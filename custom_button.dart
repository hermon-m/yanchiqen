import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.orange[200],
          shape: StadiumBorder(),
          minimumSize: Size(180, 44),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.black)),
      ),
    );
  }
}