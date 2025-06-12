import 'package:flutter/material.dart';

class ArticleContentScreen extends StatelessWidget {
  final String title;
  final String content;

  const ArticleContentScreen({
    Key? key,
    required this.title,
    required this.content,
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
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: const BoxDecoration(
          color: Color(0xFFD9D9D9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(26),
            topRight: Radius.circular(26),
          ),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
          child: Text(
            content,
            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}