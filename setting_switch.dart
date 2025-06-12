import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsSwitch({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}