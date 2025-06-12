import 'package:flutter/material.dart';

class EmojiFeelingSelector extends StatelessWidget {
  final String? selectedEmoji;
  final List<String> emojis;
  final ValueChanged<String> onEmojiSelected;

  const EmojiFeelingSelector({
    Key? key,
    required this.selectedEmoji,
    required this.emojis,
    required this.onEmojiSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: emojis
          .map((e) => GestureDetector(
        onTap: () => onEmojiSelected(e),
        child: Text(
          e,
          style: TextStyle(
            fontSize: 32,
            backgroundColor: selectedEmoji == e ? Colors.orange[100] : Colors.transparent,
          ),
        ),
      ))
          .toList(),
    );
  }
}