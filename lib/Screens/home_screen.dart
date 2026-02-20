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
      extendBody: true, // Crucial for the notched FAB look
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: isDark ? Colors.grey.shade900 : Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8, // Clean gap between bar and FAB
        elevation: 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
            _buildNavItem(1, Icons.search_rounded, Icons.search_outlined),
            const SizedBox(width: 48), // Spacer for the FAB in the middle
            _buildNavItem(2, Icons.messenger_rounded, Icons.messenger_outline_rounded),
            _buildNavItem(3, Icons.person_rounded, Icons.person_outline_rounded),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 5,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Addpost()),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.blueAccent],
            ),
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
    );
  }

  // Helper widget for a cleaner, more unique navigation item
  Widget _buildNavItem(int index, IconData selectedIcon, IconData unselectedIcon) {
    bool isSelected = _currentIndex == index;
    return IconButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      icon: Icon(
        isSelected ? selectedIcon : unselectedIcon,
        size: 28,
        color: isSelected ? Colors.blueAccent : Colors.grey.shade500,
      ),
    );
  }
}