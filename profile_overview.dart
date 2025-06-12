import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'basic_info_form.dart';
import 'cycle_info_form.dart';
import 'preferences_screen.dart';

class ProfileOverview extends StatelessWidget {
  final String userName;

  const ProfileOverview({Key? key, this.userName = "Name"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color pinkColor = Color(0xFFFFB6C1); // Soft pink
    const Color cardBg = Color(0xFFF3F3F3);   // Light gray

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back arrow and title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => HomeScreen()),
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: pinkColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Hello box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Hello there,\n[$userName]",
                  style: const TextStyle(
                    color: pinkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Profile Detail Section",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // Detail card with menu options
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _ProfileTile(
                      title: "Basic Information",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => BasicInfoForm()),
                        );
                      },
                    ),
                    _ProfileTile(
                      title: "Cycle Information",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CycleInfoForm()),
                        );
                      },
                    ),
                    _ProfileTile(
                      title: "My Preferences",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => PreferencesScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.black),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              dense: true,
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black87,
              indent: 8,
              endIndent: 8,
            ),
          ],
        ),
      ),
    );
  }
}