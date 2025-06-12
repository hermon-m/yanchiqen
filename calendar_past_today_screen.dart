import 'package:flutter/material.dart';

class CalendarPastTodayScreen extends StatelessWidget {
  final DateTime selectedDate;

  const CalendarPastTodayScreen({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "Calendar - Past/Today",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD96B91),
                    ),
                  ),
                ],
              ),
            ),
            // Date Display
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD96B91),
                ),
              ),
            ),
            // Mood Logging Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  const Text(
                    "How are you feeling today?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD96B91),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Emoji Mood Options
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.sentiment_very_satisfied, size: 32, color: Color(0xFFB0B0B0)),
                      Icon(Icons.sentiment_satisfied, size: 32, color: Color(0xFFB0B0B0)),
                      Icon(Icons.sentiment_neutral, size: 32, color: Color(0xFFB0B0B0)),
                      Icon(Icons.sentiment_dissatisfied, size: 32, color: Color(0xFFB0B0B0)),
                      Icon(Icons.sentiment_very_dissatisfied, size: 32, color: Color(0xFFB0B0B0)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Log Period Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle Log Period
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD96B91),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      "Log Period",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Save/Cancel Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Cancel and go back
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Save the mood and log period
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD96B91),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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