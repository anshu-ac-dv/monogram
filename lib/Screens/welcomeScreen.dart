import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  final ref = FirebaseDatabase.instance.ref('Posts');

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monogram",
                    style: GoogleFonts.lobster(
                      fontSize: 28,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Icon(Icons.notifications_none_rounded, size: 28),
                ],
              ),
            ),

            // Stories Section (Mocked for UI)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: isDark ? Colors.black : Colors.white,
                            child: const CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage("images/google.png"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          index == 0 ? "You" : "User $index",
                          style: GoogleFonts.roboto(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Divider(thickness: 0.5),

            // Real-Time Post Feed
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Center(child: CircularProgressIndicator()),
                itemBuilder: (context, snapshot, animation, index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: PostWidget(
                      title: snapshot.child('title').value.toString(),
                      email: snapshot.child('email').value.toString(),
                      postImage: snapshot.child('postImage').value?.toString() ?? "",
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80), // Padding for the floating nav bar
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final String title;
  final String email;
  final String postImage;

  const PostWidget({
    super.key,
    required this.title,
    required this.email,
    required this.postImage,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar and Username
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  child: Text(
                    email.isNotEmpty ? email[0].toUpperCase() : "U",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      email.split('@')[0],
                      style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const Text(
                      "Just now",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ),

          // Caption Text
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),

          // Post Image with loading states
          if (postImage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  postImage,
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 350,
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  },
                ),
              ),
            ),

          // Custom Action Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildActionButton(Icons.favorite_border_rounded, "14"),
                    const SizedBox(width: 15),
                    _buildActionButton(Icons.chat_bubble_outline_rounded, "3"),
                    const SizedBox(width: 15),
                    _buildActionButton(Icons.send_rounded, ""),
                  ],
                ),
                const Icon(Icons.bookmark_border_rounded, size: 26),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String count) {
    return Row(
      children: [
        Icon(icon, size: 26),
        if (count.isNotEmpty) ...[
          const SizedBox(width: 5),
          Text(count, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ],
    );
  }
}