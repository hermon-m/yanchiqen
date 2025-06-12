import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/period_data.dart';
import '../widgets/month_view.dart';
import '../widgets/year_view.dart';
import 'calendar_edit_screen.dart';

class CalendarMainScreen extends StatefulWidget {
  const CalendarMainScreen({Key? key}) : super(key: key);

  @override
  State<CalendarMainScreen> createState() => _CalendarMainScreenState();
}

class _CalendarMainScreenState extends State<CalendarMainScreen> {
  int _selectedToggle = 1; // 0: Year, 1: Month
  DateTime _displayedMonth = DateTime.now();
  int _displayedYear = DateTime.now().year;

  void _prevMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.month == 1 ? _displayedMonth.year - 1 : _displayedMonth.year,
        _displayedMonth.month == 1 ? 12 : _displayedMonth.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.month == 12 ? _displayedMonth.year + 1 : _displayedMonth.year,
        _displayedMonth.month == 12 ? 1 : _displayedMonth.month + 1,
        1,
      );
    });
  }

  void _navigateToEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalendarEditScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final periodData = Provider.of<PeriodData>(context);

    // Extract days of the displayed month from periodDays
    final List<int> periodDaysInMonth = periodData.periodDays
        .where((date) => date.year == _displayedMonth.year && date.month == _displayedMonth.month)
        .map((date) => date.day)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Image.asset(
                    'assets/yanchiqen_logo.png',
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "YanchiQen",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFFD96B91),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
                child: Column(
                  children: [
                    // Calendar Title
                    const Text(
                      "Calendar",
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD96B91),
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Toggle Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _selectedToggle = 1),
                          child: Container(
                            width: 62,
                            height: 31,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedToggle == 1 ? Color(0xFFD96B91) : Color(0xFFF5EFE6),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Text(
                              "Month",
                              style: TextStyle(
                                color: _selectedToggle == 1
                                    ? Colors.white
                                    : Color(0xFFB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => setState(() => _selectedToggle = 0),
                          child: Container(
                            width: 62,
                            height: 31,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: _selectedToggle == 0 ? Color(0xFFFEE191) : Color(0xFFF5EFE6),
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Text(
                              "Year",
                              style: TextStyle(
                                color: _selectedToggle == 0
                                    ? Colors.white
                                    : Color(0xFFB0B0B0),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // Edit Period Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: _navigateToEditScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD96B91),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          "Edit Period Date",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Calendar View
                    Expanded(
                      child: _selectedToggle == 1
                          ? MonthView(
                        displayedMonth: _displayedMonth,
                        today: DateTime.now(),
                        periodDays: periodDaysInMonth, // Pass the filtered days of the month
                        ovulationDays: [],
                        fertileDays: [],
                        onPrevMonth: _prevMonth,
                        onNextMonth: _nextMonth,
                      )
                          : YearView(
                        year: _displayedYear,
                        onMonthTap: (month) {
                          setState(() {
                            _displayedMonth = DateTime(_displayedYear, month, 1);
                            _selectedToggle = 1;
                          });
                        },
                        onPrevYear: () {
                          setState(() {
                            _displayedYear--;
                          });
                        },
                        onNextYear: () {
                          setState(() {
                            _displayedYear++;
                          });
                        },
                      ),
                    ),
                    // Legend
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_florist, size: 18, color: Color(0xFFD96B91)),
                            const SizedBox(width: 4),
                            const Text(
                              "Ovulation Day",
                              style: TextStyle(fontSize: 13, color: Color(0xFFD96B91)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFAEBF),
                                shape: BoxShape.circle,
                                border: Border.all(color: Color(0xFFD96B91), width: 1.5),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Period Days",
                              style: TextStyle(fontSize: 13, color: Color(0xFFD96B91)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFFEE191), width: 2),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              "Fertile Window",
                              style: TextStyle(fontSize: 13, color: Color(0xFFD96B91)),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacementNamed(context, '/home');
          if (index == 1) return;
          if (index == 2) Navigator.pushReplacementNamed(context, '/education');
          if (index == 3) Navigator.pushReplacementNamed(context, '/peer_support');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, size: 26),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, size: 28),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline, size: 28),
            label: "",
          ),
        ],
        selectedItemColor: Color(0xFFD96B91),
        unselectedItemColor: Color(0xFFB0B0B0),
        backgroundColor: Color(0xFFF5EFE6),
        elevation: 4,
      ),
    );
  }
}