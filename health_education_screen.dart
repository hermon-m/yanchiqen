import 'package:flutter/material.dart';
import 'home_screen.dart' as home;
import 'calendar_main_screen.dart';
import 'peer_support.dart'; // Make sure this file contains a class named PeerSupport

// Article Content Screen
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
          child: Text(
            content,
            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

// Video Content Screen
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

// ---- TOPIC TAB LIST WIDGET HERE ----
class TopicTabList extends StatefulWidget {
  final String topicName;
  final List<String> videos;
  final List<String> articles;
  final VoidCallback onBack;

  const TopicTabList({
    required this.topicName,
    required this.videos,
    required this.articles,
    required this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  _TopicTabListState createState() => _TopicTabListState();
}

class _TopicTabListState extends State<TopicTabList> {
  int _tabIndex = 0; // 0 = article, 1 = video

  @override
  Widget build(BuildContext context) {
    final items = _tabIndex == 0 ? widget.articles : widget.videos;
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: widget.onBack,
            ),
            Text(
              widget.topicName,
              style: TextStyle(
                  color: Color(0xFFF48C8C),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTabButton('Article', 0),
            _buildTabButton('Video', 1),
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_tabIndex == 0) {
                        // Article tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ArticleContentScreen(
                              title: 'Article ${index + 1}',
                              content: 'Content for ${item}...',
                            ),
                          ),
                        );
                      } else {
                        // Video tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoContentScreen(
                              title: 'Video ${index + 1}',
                              description: 'Short description for ${item}...',
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String label, int index) {
    final selected = _tabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _tabIndex = index),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? Color(0xFFF48C8C) : Colors.white,
          border: Border.all(color: Color(0xFFF48C8C)),
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(index == 0 ? 16 : 0),
            right: Radius.circular(index == 1 ? 16 : 0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 7),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Color(0xFFF48C8C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ---- MAIN HEALTH EDUCATION SCREEN ----
class HealthEducationScreen extends StatefulWidget {
  @override
  _HealthEducationScreenState createState() => _HealthEducationScreenState();
}

class _HealthEducationScreenState extends State<HealthEducationScreen> {
  int _screen = 0;
  String _selectedTopic = '';

  final List<Map<String, String>> healthTopics = [
    {'label': 'Menstrual Hygiene', 'key': 'menstrual'},
    {'label': 'Family Planning', 'key': 'family'},
    {'label': 'Pregnancy', 'key': 'pregnancy'},
    {'label': 'One Stop Centers', 'key': 'centers'},
  ];

  final List<String> videos = [
    'Video 1',
    'Video 2',
    'Video 3',
    'Video 4',
  ];

  final List<String> articles = [
    'Article 1',
    'Article 2',
    'Article 3',
    'Article 4',
  ];

  void _onNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => home.HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CalendarMainScreen()),
        );
        break;
      case 2:
      // Stay on health education
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PeerSupport()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2E8DF),
      body: Center(
        child: Container(
          width: 270,
          child: _screen == 0
              ? _buildHomeScreen()
              : _buildTopicScreen(_selectedTopic),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
        ],
        currentIndex: 2,
        onTap: _onNavTap,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.pink[200],
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHomeScreen() {
    return Column(
      children: [
        SizedBox(height: 22),
        Image.asset(
          'assets/yanchiqen_logo.png',
          width: 60,
          height: 60,
        ),
        SizedBox(height: 8),
        Text(
          'Health Education',
          style: TextStyle(
            color: Color(0xFFF48C8C),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 14),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              children: healthTopics
                  .map((topic) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTopic = topic['key']!;
                      _screen = 1;
                    });
                  },
                  child: Text(
                    topic['label']!,
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopicScreen(String topicKey) {
    String topicName = healthTopics
        .firstWhere((t) => t['key'] == topicKey, orElse: () => healthTopics[0])['label']!;
    return TopicTabList(
      topicName: topicName,
      videos: videos,
      articles: articles,
      onBack: () {
        setState(() {
          _screen = 0;
        });
      },
    );
  }
}