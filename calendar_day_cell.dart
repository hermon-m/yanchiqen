import 'package:flutter/material.dart';

class CalendarDayCell extends StatelessWidget {
  final DateTime date;
  final bool isPeriod;
  final bool isOvulation;
  final bool isFertile;

  const CalendarDayCell({
    Key? key,
    required this.date,
    this.isPeriod = false,
    this.isOvulation = false,
    this.isFertile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Add legend icons and proper styling
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: isPeriod
            ? Colors.red[100]
            : isOvulation
            ? Colors.green[100]
            : isFertile
            ? Colors.blue[100]
            : Colors.white,
        shape: BoxShape.circle,
      ),
      width: 36,
      height: 36,
      child: Center(child: Text("${date.day}")),
    );
  }
}