import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/ProfileScreen.dart';
import 'package:monogram/Screens/SearchScreen.dart';
import 'package:monogram/Screens/addPost.dart';
import 'package:monogram/Screens/chatScreen.dart';
import 'package:monogram/Screens/login_screen.dart';
import 'package:monogram/Screens/welcomeScreen.dart';
import 'package:monogram/Toast/errorToast.dart';

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
    return Scaffold(
      extendBody: true, // Allows the FAB to look better with the nav bar
      appBar: AppBar(
        title: Text(
          "Monogram",
          style: GoogleFonts.lobster(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }).onError((error, stackTrace) {
                  Errortoast().showToast(error.toString());
                });
              },
              icon: const Icon(Icons.logout_rounded, color: Colors.black87, size: 24),
            ),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.shade400,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              activeIcon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.messenger_outline_rounded),
              activeIcon: Icon(Icons.messenger_rounded),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 65,
        width: 65,
        margin: const EdgeInsets.only(top: 30), // Adjust position relative to Nav Bar
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          elevation: 8,
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Addpost()),
            );
          },
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.lightGreenAccent.shade200,
                  Colors.lightGreenAccent,
                ],
              ),
            ),
            child: const Icon(Icons.add_rounded, color: Colors.black, size: 35),
          ),
        ),
      ),
    );
  }
}
