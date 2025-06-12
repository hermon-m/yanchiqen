bool isEmail(String input) {
  return RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(input);
}

bool isPhone(String input) {
  return RegExp(r"^\+?[0-9]{7,15}$").hasMatch(input);
}

bool isValidPassword(String input) {
  return input.length >= 6;
}

// ===== EXPANDED FOR MAIN APP FLOW BELOW =====

bool isValidName(String input) {
  return input.trim().isNotEmpty;
}

bool isValidAge(String input) {
  final age = int.tryParse(input);
  return age != null && age > 0 && age < 120;
}

bool isValidCycleLength(String input) {
  final days = int.tryParse(input);
  return days != null && days >= 21 && days <= 40;
}

bool isValidPeriodLength(String input) {
  final days = int.tryParse(input);
  return days != null && days >= 2 && days <= 10;
}

bool isValidAbout(String input) {
  return input.length <= 200; // Or whatever limit you want
}