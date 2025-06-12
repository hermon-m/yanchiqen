import 'package:flutter/material.dart';

class PeriodData extends ChangeNotifier {
  List<DateTime> periodDays = []; // List of all saved period days

  void addPeriodDays(List<DateTime> newDays) {
    periodDays.addAll(newDays);
    notifyListeners();
  }

  void clearPeriodDays() {
    periodDays.clear();
    notifyListeners();
  }

  bool isPeriodDay(DateTime day) {
    return periodDays.any((periodDay) =>
    periodDay.year == day.year && periodDay.month == day.month && periodDay.day == day.day);
  }
}