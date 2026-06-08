import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/ProfileScreen.dart';
import 'package:monogram/Screens/SearchScreen.dart';
import 'package:monogram/Screens/addPost.dart';
import 'package:monogram/Screens/chatScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeFeed(),
      const SearchScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.grid_view_rounded),
          _buildNavItem(1, Icons.search_rounded),
          
          // Add Button
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPost())),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
          
          _buildNavItem(2, Icons.chat_bubble_outline_rounded),
          _buildNavItem(3, Icons.person_outline_rounded),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    bool isSelected = _currentIndex == index;
    return IconButton(
      onPressed: () => setState(() => _currentIndex = index),
      icon: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.blueAccent : Colors.grey.shade400,
      ),
    );
  }
}

class HomeFeed extends StatelessWidget {
  const HomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "MONOGRAM",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            letterSpacing: 2,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded, color: isDark ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Stories Section
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildStoryItem(index, isDark);
              },
            ),
          ),

          // Feed
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => _buildPost(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(int index, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueAccent, width: 2),
            ),
            child: const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage("images/google.png"),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            index == 0 ? "You" : "User $index",
            style: TextStyle(fontSize: 10, color: isDark ? Colors.white70 : Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildPost(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage("images/google.png")),
            title: Text("Alex Johnson", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("New York, USA", style: TextStyle(fontSize: 12)),
            trailing: Icon(Icons.more_vert),
          ),
          Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(image: AssetImage("images/google.png"), fit: BoxFit.cover),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.favorite_rounded, color: Colors.redAccent),
                SizedBox(width: 5),
                Text("1.2k", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 20),
                Icon(Icons.chat_bubble_outline_rounded, color: Colors.blueAccent),
                SizedBox(width: 5),
                Text("45", style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.bookmark_border_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
