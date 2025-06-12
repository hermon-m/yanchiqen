import 'package:flutter/material.dart';

class VideoContentScreen extends StatelessWidget {
  final String title;
  final String description;

  const VideoContentScreen({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Color(0xFFF48C8C)),
        title: Text(
          title,
          style: TextStyle(color: Color(0xFFF48C8C), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.grey[400]),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video placeholder
              Center(
                child: Container(
                  width: 220,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.play_circle_outline, size: 48, color: Colors.grey[600]),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}