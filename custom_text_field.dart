import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.isPassword = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscure = false;

  @override
  void initState() {
    obscure = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        fillColor: Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey),
          onPressed: () => setState(() => obscure = !obscure),
        )
            : null,
      ),
    );
  }
}