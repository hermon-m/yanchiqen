import 'package:flutter/material.dart';

// Post model with per-post comments
class PeerSupportPost {
  final String user;
  final String timeAgo;
  final String comment;
  int likes;
  bool liked;
  final List<String> comments;

  PeerSupportPost({
    required this.user,
    required this.timeAgo,
    required this.comment,
    this.likes = 0,
    this.liked = false,
    List<String>? comments,
  }) : comments = comments ?? [];
}

// Main Peer Support Feed Screen
class PeerSupport extends StatefulWidget {
  const PeerSupport({Key? key}) : super(key: key);

  @override
  State<PeerSupport> createState() => _PeerSupportState();
}

class _PeerSupportState extends State<PeerSupport> {
  List<PeerSupportPost> posts = [
    PeerSupportPost(
      user: "Anonymous",
      timeAgo: "2h ago",
      comment: "Comment...",
      comments: ["So true!", "Thank you for sharing."],
    ),
    PeerSupportPost(
      user: "Anonymous",
      timeAgo: "3h ago",
      comment: "Comment...",
    ),
  ];

  void _addPost(String content) {
    setState(() {
      posts.insert(
        0,
        PeerSupportPost(
          user: "Anonymous",
          timeAgo: "now",
          comment: content,
        ),
      );
    });
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index].liked = !posts[index].liked;
      posts[index].likes += posts[index].liked ? 1 : -1;
    });
  }

  void _reportPost(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Report Post"),
        content: const Text("Are you sure you want to report this post?"),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Report"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post reported. Thank you!")),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showComments(int postIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PeerSupportCommentScreen(
          post: posts[postIndex],
          onAddComment: (text) {
            setState(() {
              posts[postIndex].comments.add(text);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasPosts = posts.isNotEmpty;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _PeerSupportHeader(),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7C8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 4),
            ),
            child: const Text("Popular", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: hasPosts
                ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: _PeerSupportPostCard(
                    post: post,
                    onLike: hasPosts ? () => _toggleLike(index) : null,
                    onComment: hasPosts ? () => _showComments(index) : null,
                    onReport: hasPosts ? () => _reportPost(index) : null,
                  ),
                );
              },
            )
                : Center(
              child: Text(
                "No posts yet.\nTap \"New Post\" to get started!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PeerSupportPostScreen(
                      onPost: _addPost,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, size: 20, color: Colors.white),
              label: const Text("New Post", style: TextStyle(fontWeight: FontWeight.w500)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF7C8A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 7),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _PeerSupportBottomNavBar(currentIndex: 3),
    );
  }
}

class _PeerSupportHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F1EA),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      padding: const EdgeInsets.only(top: 42, bottom: 22),
      child: Column(
        children: [
          Image.asset(
            'assets/yanchiqen_logo.png',
            width: 75,
            height: 55,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 5),
          const Text(
            "Peer Support",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF7C8A),
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            "“You are not alone — share, ask, connect.”",
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFFC9896A),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _PeerSupportPostCard extends StatelessWidget {
  final PeerSupportPost post;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onReport;
  const _PeerSupportPostCard({
    required this.post,
    this.onLike,
    this.onComment,
    this.onReport,
  });

  @override
  Widget build(BuildContext context) {
    // Only show action buttons if callbacks are not null (i.e., posts exist)
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xFF6A7A89), size: 18),
              const SizedBox(width: 7),
              Text(
                "${post.user} - ${post.timeAgo}",
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6A7A89),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            post.comment,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: post.liked ? Color(0xFFFF7C8A) : Colors.grey,
                  size: 21,
                ),
                onPressed: onLike,
                tooltip: 'Like',
              ),
              if (post.likes > 0)
                Text(
                  post.likes.toString(),
                  style: TextStyle(
                    color: Color(0xFFFF7C8A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.warning_amber_rounded, color: Color(0xFFF9C86A), size: 21),
                onPressed: onReport,
                tooltip: 'Report',
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: Color(0xFF6A7A89), size: 21),
                onPressed: onComment,
                tooltip: 'Comment',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Peer Support Post Screen
class PeerSupportPostScreen extends StatefulWidget {
  final Function(String) onPost;
  const PeerSupportPostScreen({Key? key, required this.onPost}) : super(key: key);

  @override
  State<PeerSupportPostScreen> createState() => _PeerSupportPostScreenState();
}

class _PeerSupportPostScreenState extends State<PeerSupportPostScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _posting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          _PeerSupportHeaderWithBack(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: "Type anything you want to share...",
                  hintStyle: TextStyle(color: Color(0xFF6A7A89), fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _posting
                ? null
                : () {
              final content = _controller.text.trim();
              if (content.isNotEmpty) {
                setState(() => _posting = true);
                Future.delayed(const Duration(milliseconds: 400), () {
                  widget.onPost(content);
                  Navigator.pop(context);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7C8A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 9),
            ),
            child: const Text("Post", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      bottomNavigationBar: _PeerSupportBottomNavBar(currentIndex: 3),
    );
  }
}

// Peer Support Comment Screen -- for per-post comments
class PeerSupportCommentScreen extends StatefulWidget {
  final PeerSupportPost post;
  final Function(String) onAddComment;
  const PeerSupportCommentScreen({super.key, required this.post, required this.onAddComment});

  @override
  State<PeerSupportCommentScreen> createState() => _PeerSupportCommentScreenState();
}

class _PeerSupportCommentScreenState extends State<PeerSupportCommentScreen> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final comments = widget.post.comments;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F1EA),
        elevation: 0,
        title: const Text(
          "Comments",
          style: TextStyle(
            color: Color(0xFFFF7C8A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF6A7A89)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.post.comment,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: comments.isEmpty
                  ? Center(child: Text("No comments yet.", style: TextStyle(color: Colors.grey[600])))
                  : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, idx) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.person, color: Color(0xFF6A7A89), size: 18),
                      SizedBox(width: 7),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF0E9E3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(comments[idx], style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _commentController.text.trim().isEmpty
                      ? null
                      : () {
                    final text = _commentController.text.trim();
                    if (text.isNotEmpty) {
                      widget.onAddComment(text);
                      setState(() {
                        _commentController.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7C8A),
                  ),
                  child: const Text("Send"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PeerSupportHeaderWithBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF8F1EA),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      padding: const EdgeInsets.only(top: 42, bottom: 22),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF6A7A89)),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Column(
            children: [
              Image.asset(
                'assets/yanchiqen_logo.png',
                width: 75,
                height: 55,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              const Text(
                "Peer Support",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF7C8A),
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                "“You are not alone — share, ask, connect.”",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFFC9896A),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PeerSupportBottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _PeerSupportBottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) return;
        if (index == 0) Navigator.pushReplacementNamed(context, '/home');
        if (index == 1) Navigator.pushReplacementNamed(context, '/calendar');
        if (index == 2) Navigator.pushReplacementNamed(context, '/education');
        if (index == 3) return;
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.school), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: ""),
      ],
      selectedItemColor: Color(0xFFFF7C8A),
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFFF5F5F5),
      elevation: 4,
    );
  }
}