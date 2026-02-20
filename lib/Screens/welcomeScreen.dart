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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Monogram Feed",
                    style: GoogleFonts.lobster(
                      fontSize: 24,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Icon(Icons.notifications_none_rounded),
                ],
              ),
            ),
            
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
            const SizedBox(height: 80), // Space for notched FAB
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blueAccent.withOpacity(0.1),
                  child: Text(
                    email.isNotEmpty ? email[0].toUpperCase() : "U",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
              ],
            ),
          ),

          // Post Text
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

          // Post Image
          if (postImage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  postImage,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 300,
                      color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 50),
                    );
                  },
                ),
              ),
            ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.favorite_border_rounded), onPressed: () {}),
                IconButton(icon: const Icon(Icons.chat_bubble_outline_rounded), onPressed: () {}),
                IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {}),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
