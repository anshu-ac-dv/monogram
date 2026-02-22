import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monogram/Screens/ProfileScreen.dart';
import 'package:monogram/Screens/SearchScreen.dart';
import 'package:monogram/Screens/addPost.dart';
import 'package:monogram/Screens/chatScreen.dart';
import 'package:monogram/Screens/welcomeScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const Welcomescreen(),
    const Searchscreen(),
    const Chatscreen(),
    const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true, // Allows content to flow behind the floating dock
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 25), // Floating effect
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900.withOpacity(0.9) : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
            _buildNavItem(1, Icons.search_rounded, Icons.search_outlined),

            // Central Dynamic Add Button
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
    );
  }

  // Modern Navigation Item with Animated Feedback
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
          color: isSelected ? Colors.blueAccent.withOpacity(0.12) : Colors.transparent,
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