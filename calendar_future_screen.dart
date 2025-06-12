import 'package:flutter/material.dart';

class CalendarFutureScreen extends StatelessWidget {
  const CalendarFutureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Show chance of pregnancy, ovulation info
    return Scaffold(
      appBar: AppBar(title: const Text("Future Date")),
      body: Center(child: Text("Future Date Info (Chance of Pregnancy)")),
    );
  }
}