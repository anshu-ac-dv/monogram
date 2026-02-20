import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
      extendBody: true, // Allows the FAB to look better with the nav bar
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10, // Padding for the FAB notch
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 0 ? Icons.home_filled : Icons.home,
                          color: _currentIndex == 0 ? Colors.white : Colors.white70,
                        ),
                        Text('Home', style: TextStyle(color: _currentIndex == 0 ? Colors.white : Colors.white70)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: _currentIndex == 1 ? Colors.white : Colors.white70,
                        ),
                        Text('Search', style: TextStyle(color: _currentIndex == 1 ? Colors.white : Colors.white70)),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                         _currentIndex == 2 ? Icons.messenger_rounded : Icons.messenger_outline_rounded,
                          color: _currentIndex == 2 ? Colors.white : Colors.white70,
                        ),
                        Text('Chat', style: TextStyle(color: _currentIndex == 2 ? Colors.white : Colors.white70)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentIndex == 3 ? Icons.person_rounded : Icons.person_outline_rounded,
                          color: _currentIndex == 3 ? Colors.white : Colors.white70,
                        ),
                        Text('Profile', style: TextStyle(color: _currentIndex == 3 ? Colors.white : Colors.white70)),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
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
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ],
            ),
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 35),
        ),
      ),
    );
  }
}
