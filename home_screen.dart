import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/period_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, this.userName = ""}) : super(key: key);

  final String userName;

  @override
  Widget build(BuildContext context) {
    final periodData = Provider.of<PeriodData>(context);

    // Calculate next period estimation
    final nextPeriodDate = periodData.periodDays.isNotEmpty
        ? periodData.periodDays.last.add(const Duration(days: 28))
        : DateTime.now();
    final daysUntilNextPeriod = nextPeriodDate.difference(DateTime.now()).inDays;

    final chanceText = "Low chances of getting pregnant";

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with profile icon (left)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.13),
                          blurRadius: 3,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.person, color: Color(0xFFB0B0B0), size: 22),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            // App logo centered
            Image.asset(
              'assets/yanchiqen_logo.png',
              width: 70,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 4),
            // "YanchiQen" below logo
            const Text(
              "YanchiQen",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFFD96B91),
              ),
            ),
            const SizedBox(height: 10),
            // Greeting card
            Container(
              width: 232,
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x10000000),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                "Hello there,\n$userName",
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFD96B91),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // "Period in" label
            const Text(
              "Period in",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            // Days count
            Text(
              "$daysUntilNextPeriod days",
              style: const TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            // Chances text
            Text(
              chanceText,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 28),
            // Log Period Button (small, pill, light pink)
            SizedBox(
              width: 110,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: const Color(0xFFFFAEBF), // Light pink
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                onPressed: () => Navigator.pushNamed(context, '/calendar_edit'),
                child: const Text(
                  "Log Period",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                  ),
                ),
              ),
            ),
            // Expand to bottom nav
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) return;
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/calendar');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/education');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/peer_support');
          }
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
        selectedItemColor: const Color(0xFFD96B91),
        unselectedItemColor: const Color(0xFFB0B0B0),
        backgroundColor: const Color(0xFFF5EFE6),
        elevation: 4,
      ),
    );
  }
}