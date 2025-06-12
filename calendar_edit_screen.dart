import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/period_data.dart';

class CalendarEditScreen extends StatefulWidget {
  const CalendarEditScreen({Key? key}) : super(key: key);

  @override
  State<CalendarEditScreen> createState() => _CalendarEditScreenState();
}

class _CalendarEditScreenState extends State<CalendarEditScreen> {
  DateTime displayedMonth = DateTime.now(); // Current displayed month
  final List<int> selectedDays = []; // Days currently marked as "Period Days"

  void _prevMonth() {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.month == 1 ? displayedMonth.year - 1 : displayedMonth.year,
        displayedMonth.month == 1 ? 12 : displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.month == 12 ? displayedMonth.year + 1 : displayedMonth.year,
        displayedMonth.month == 12 ? 1 : displayedMonth.month + 1,
        1,
      );
    });
  }

  void _toggleDay(int day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day); // Unmark the day
      } else {
        selectedDays.add(day); // Mark the day
      }
    });
  }

  void _savePeriodDays() {
    final periodData = Provider.of<PeriodData>(context, listen: false);

    // Convert selectedDays to DateTime and save to shared state
    final newPeriodDays = selectedDays.map((day) {
      return DateTime(displayedMonth.year, displayedMonth.month, day);
    }).toList();

    periodData.addPeriodDays(newPeriodDays);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Period days saved successfully!')),
    );

    Navigator.pop(context); // Return to the previous screen
  }

  void _cancelChanges() {
    Navigator.pop(context); // Discard changes and return
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final firstWeekday = DateTime(displayedMonth.year, displayedMonth.month, 1).weekday % 7; // 0: Sunday, ..., 6: Saturday

    List<Widget> dayWidgets = [];
    for (int i = 0; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox()); // Empty spaces for days before the 1st
    }
    for (int day = 1; day <= daysInMonth; day++) {
      dayWidgets.add(
        GestureDetector(
          onTap: () => _toggleDay(day),
          child: Column(
            children: [
              Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(
                selectedDays.contains(day)
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: selectedDays.contains(day) ? Colors.red : Colors.grey,
                size: 24,
              ),
            ],
          ),
        ),
      );
    }
    while (dayWidgets.length % 7 != 0) {
      dayWidgets.add(const SizedBox()); // Fill remaining spaces
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Image.asset(
                    'assets/yanchiqen_logo.png',
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Calendar",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD96B91),
                    ),
                  ),
                ],
              ),
            ),
            // Month Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD96B91)),
                  onPressed: _prevMonth,
                ),
                Text(
                  "${displayedMonth.month} ${displayedMonth.year}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD96B91),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Color(0xFFD96B91)),
                  onPressed: _nextMonth,
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Days of the Week
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text("Sun", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Mon", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Tue", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Wed", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Thu", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Fri", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("Sat", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            // Calendar Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(10),
                children: dayWidgets,
              ),
            ),
            // Save/Cancel Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _cancelChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _savePeriodDays,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD96B91),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
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