import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
      body: ListView.builder(
        itemCount: 5, // Simulating a feed with 5 posts
        itemBuilder: (context, index) {
          return const PostWidget();
        },
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: Profile Picture, Username, and More Icon
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: const AssetImage("images/google.png"), // Placeholder
                    backgroundColor: Colors.grey.shade300,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "anshu_kr",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),

        // Main Post Image
        Container(
          width: double.infinity,
          height: 400,
          color: Colors.grey.shade200,
          child: Image.asset(
            "images/x.png", // Using your existing asset
            fit: BoxFit.contain,
          ),
        ),

        // Action Buttons: Like, Comment, Share, and Save
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_border, size: 28),
                  const SizedBox(width: 16),
                  const Icon(Icons.chat_bubble_outline, size: 26),
                  const SizedBox(width: 16),
                  const Icon(Icons.send_outlined, size: 26),
                ],
              ),
              const Icon(Icons.bookmark_border, size: 28),
            ],
          ),
        ),

        // Likes and Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1,234 likes",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.roboto(
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "anshu_kr ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: "Building something amazing with Flutter and Firebase! 🚀 #monogram #flutterdev",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "View all 15 comments",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                "2 hours ago",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
