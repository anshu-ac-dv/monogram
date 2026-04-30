import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
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
  final auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeFeed(),
      const Searchscreen(),
      const Chatscreen(),
      const Profilescreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildFloatingDock(isDark),
    );
  }

  Widget _buildFloatingDock(bool isDark) {
    return Container(
      height: 70,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      decoration: BoxDecoration(
        color: isDark ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black12,
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
                _buildNavItem(1, Icons.search_rounded, Icons.search_outlined),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Addpost()),
                    );
                  },
                  child: Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Colors.blue, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
                  ),
                ),

                _buildNavItem(2, Icons.messenger_rounded, Icons.messenger_outline_rounded),
                _buildNavItem(3, Icons.person_rounded, Icons.person_outline_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData selectedIcon, IconData unselectedIcon) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          size: 28,
          color: isSelected ? Colors.blueAccent : Colors.grey.shade500,
        ),
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
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          "Monogram",
          style: GoogleFonts.lobster(
            fontSize: 28,
            color: isDark ? Colors.white : Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border_rounded, color: isDark ? Colors.white : Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.send_rounded, color: isDark ? Colors.white : Colors.black87),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Stories Section
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildStoryItem(index, isDark);
              },
            ),
          ),
          const Divider(height: 1, thickness: 0.2),

          // Posts Feed
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildPostCard(isDark);
            },
          ),
          const SizedBox(height: 100), // Space for floating dock
        ],
      ),
    );
  }

  Widget _buildStoryItem(int index, bool isDark) {
    bool isMe = index == 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isMe ? [Colors.grey.shade300, Colors.grey.shade300] : [Colors.purple, Colors.orange, Colors.yellow],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("images/google.png"),
                  ),
                ),
              ),
              if (isMe)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.add, size: 18, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            isMe ? "Your Story" : "User $index",
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Post Header
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage("images/google.png"),
          ),
          title: const Text("Username", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: const Text("Location, Country"),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ),

        // Post Image
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            image: const DecorationImage(
              image: AssetImage("images/google.png"), // Placeholder
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Post Actions
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble_outline_rounded)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_rounded)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border_rounded)),
          ],
        ),

        // Likes & Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("1,234 likes", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: isDark ? Colors.white : Colors.black),
                  children: const [
                    TextSpan(text: "Username ", style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: "This is a beautiful day for developing Monogram! #flutter #ui"),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "View all 45 comments",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
              ),
              const SizedBox(height: 5),
              Text(
                "2 hours ago",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
