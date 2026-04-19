import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/login_screen.dart';
import 'package:monogram/Toast/errorToast.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  final auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("Profile", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
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
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primaryColor, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: primaryColor.withOpacity(0.1),
                      child: Icon(Icons.person, size: 80, color: primaryColor),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user?.email?.split('@')[0] ?? "User Name",
              style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? "email@example.com",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            _buildProfileOption(Icons.settings_outlined, "Settings", isDark),
            _buildProfileOption(Icons.bookmark_border_rounded, "Saved Posts", isDark),
            _buildProfileOption(Icons.help_outline_rounded, "Help & Support", isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, bool isDark) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
