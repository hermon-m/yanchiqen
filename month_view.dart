import 'package:flutter/material.dart';

class MonthView extends StatelessWidget {
  final DateTime displayedMonth;
  final DateTime today;
  final List<int> periodDays;
  final List<int> ovulationDays;
  final List<int> fertileDays;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;

  const MonthView({
    Key? key,
    required this.displayedMonth,
    required this.today,
    required this.periodDays,
    required this.ovulationDays,
    required this.fertileDays,
    required this.onPrevMonth,
    required this.onNextMonth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    final List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0: Sunday, ..., 6: Saturday
    final daysInMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;

    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final isToday = today.year == displayedMonth.year &&
          today.month == displayedMonth.month &&
          today.day == day;

      Widget? icon;
      if (ovulationDays.contains(day)) {
        icon = Icon(Icons.local_florist, size: 16, color: Color(0xFFD96B91));
      } else if (periodDays.contains(day)) {
        icon = Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: Color(0xFFFFAEBF),
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFFD96B91), width: 1.5),
          ),
        );
      } else if (fertileDays.contains(day)) {
        icon = Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFFFEE191), width: 2),
            shape: BoxShape.circle,
          ),
        );
      }

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped day $day')),
            );
          },
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: isToday
                    ? BoxDecoration(
                  color: Color(0xFFE5E5E5),
                  shape: BoxShape.circle,
                )
                    : null,
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
              if (icon != null) icon
            ],
          ),
        ),
      );
    }
    while (dayWidgets.length < 42) {
      dayWidgets.add(const SizedBox());
    }

    return Column(
      children: [
        // Month navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 22, color: Color(0xFFD96B91)),
              onPressed: onPrevMonth,
              padding: EdgeInsets.zero,
            ),
            Text(
              "${monthNames[displayedMonth.month - 1]} ${displayedMonth.year}", // Convert month number to name
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFFD96B91),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 22, color: Color(0xFFD96B91)),
              onPressed: onNextMonth,
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Days of the Week Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays.map((day) {
            return Text(
              day,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Calendar Grid
        Expanded(
          child: SingleChildScrollView(
            child: GridView.count(
              shrinkWrap: true, // Allows the grid to take only as much space as needed
              crossAxisCount: 7,
              physics: const NeverScrollableScrollPhysics(), // Disable internal scrolling
              childAspectRatio: 1.0,
              padding: EdgeInsets.zero,
              children: dayWidgets,
            ),
          ),
        ),
      ],
    );
  }
}