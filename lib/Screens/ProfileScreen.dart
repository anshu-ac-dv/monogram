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
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: false,
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 0.5,
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
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Centered Profile Picture (WhatsApp Style)
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: const AssetImage("images/google.png"),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? Colors.black : Colors.white, width: 3),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Profile Information List
            _buildInfoTile(
              context,
              icon: Icons.person_outline,
              title: "Name",
              subtitle: "Anshu Kumar",
              trailing: Icons.edit_outlined,
              isDark: isDark,
            ),
            _buildInfoTile(
              context,
              icon: Icons.info_outline,
              title: "About",
              subtitle: "Flutter Developer 🚀 | Building modern apps with Firebase.",
              trailing: Icons.edit_outlined,
              isDark: isDark,
            ),
            _buildInfoTile(
              context,
              icon: Icons.email_outlined,
              title: "Email",
              subtitle: user?.email ?? "anshu@example.com",
              isDark: isDark,
            ),

            const SizedBox(height: 25),

            // Simplified Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("12", "Posts"),
                    _buildStatItem("450", "Followers"),
                    _buildStatItem("230", "Following"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions / Settings Section
            _buildActionTile(Icons.notifications_none, "Notifications", isDark),
            _buildActionTile(Icons.lock_outline, "Privacy & Security", isDark),
            _buildActionTile(Icons.help_outline, "Help Center", isDark),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context,
      {required IconData icon,
        required String title,
        required String subtitle,
        IconData? trailing,
        required bool isDark}) {
    return Container(
      color: isDark ? Colors.grey.shade900 : Colors.white,
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(icon, color: Colors.blueAccent, size: 28),
        title: Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
            height: 1.5,
          ),
        ),
        trailing: trailing != null ? Icon(trailing, size: 20, color: Colors.blueAccent) : null,
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, bool isDark) {
    return Container(
      color: isDark ? Colors.grey.shade900 : Colors.white,
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey.shade600),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}