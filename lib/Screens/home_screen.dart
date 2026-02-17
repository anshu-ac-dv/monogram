import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:monogram/Screens/login_screen.dart';
import 'package:monogram/Toast/errorToast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent,
        actions: [
          IconButton(
            onPressed: () {
              auth
                  .signOut()
                  .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  })
                  .onError((error, stackTrace) {
                    Errortoast().showToast(error.toString());
                  });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
