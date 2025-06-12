import 'package:flutter/material.dart';

class YearView extends StatelessWidget {
  final int year;
  final Function(int month) onMonthTap;
  final VoidCallback onPrevYear; // Callback for navigating to the previous year
  final VoidCallback onNextYear; // Callback for navigating to the next year

  const YearView({
    required this.year,
    required this.onMonthTap,
    required this.onPrevYear,
    required this.onNextYear,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];

    return Column(
      children: [
        // Year Navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 22, color: Color(0xFFD96B91)),
              onPressed: onPrevYear, // Navigate to the previous year
            ),
            Text(
              "$year", // Display the current year dynamically
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD96B91),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 22, color: Color(0xFFD96B91)),
              onPressed: onNextYear, // Navigate to the next year
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(), // Enable scrolling
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 4,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final month = index + 1;
              return InkWell(
                onTap: () => onMonthTap(month),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Text(
                        monthNames[index],
                        style: const TextStyle(
                          color: Color(0xFFD96B91),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      MiniMonthCalendar(year: year, month: month),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class MiniMonthCalendar extends StatelessWidget {
  final int year;
  final int month;

  const MiniMonthCalendar({required this.year, required this.month, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startWeekday = firstDay.weekday == 7 ? 0 : firstDay.weekday; // 1=Mon, ... 7=Sun -> 0=Sun, 1=Mon...
    final days = <Widget>[];

    // Weekday headers (Monday-Sunday)
    const weekDays = ["M", "T", "W", "T", "F", "S", "S"];
    days.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        7,
            (i) => SizedBox(
          width: 16,
          child: Text(
            weekDays[i],
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Colors.grey[600]),
          ),
        ),
      ),
    ));

    // Fillers for days before the 1st
    int dayCursor = 1;
    List<Widget> weekRow = [];
    for (int i = 1; i < startWeekday; i++) {
      weekRow.add(const SizedBox(width: 16));
      dayCursor++;
    }

    // Fill in the days
    for (int d = 1; d <= daysInMonth; d++) {
      weekRow.add(SizedBox(
        width: 16,
        child: Text(
          '$d',
          style: const TextStyle(fontSize: 10, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ));
      dayCursor++;
      if (weekRow.length == 7) {
        days.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: weekRow,
        ));
        weekRow = [];
      }
    }
    // Final row
    if (weekRow.isNotEmpty) {
      while (weekRow.length < 7) {
        weekRow.add(const SizedBox(width: 16));
      }
      days.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: weekRow,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: days,
    );
  }
}