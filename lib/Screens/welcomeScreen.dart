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
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Elegant Header / Stories Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Stories",
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
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
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.blueAccent.shade700],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: isDark ? Colors.black : Colors.white,
                                  child: CircleAvatar(
                                    radius: 27,
                                    backgroundImage: const AssetImage("images/google.png"),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                index == 0 ? "Your Story" : "user_$index",
                                style: GoogleFonts.roboto(
                                  fontSize: 11,
                                  color: isDark ? Colors.white70 : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(),
                  ),
                ],
              ),
            ),
        
            // Main Feed Posts
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const PostWidget();
                },
                childCount: 10,
              ),
            ),
            
            // Bottom padding for FAB
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({super.key});

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
          // Header: Profile Picture, Username
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: const AssetImage("images/google.png"),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "anshu_kr",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "New Delhi, India",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Main Post Content (Image with Rounded Corners)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "images/x.png",
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Action Buttons: Interactive Feel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildActionButton(Icons.favorite_border, "1.2k", Colors.redAccent),
                    _buildActionButton(Icons.chat_bubble_outline, "15", Colors.blueAccent),
                    _buildActionButton(Icons.send_outlined, "", Colors.greenAccent),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_border, size: 26),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Caption Section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.roboto(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                    children: [
                      const TextSpan(
                        text: "anshu_kr ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: "Loving the new vibe of Monogram! Exploring unique designs with Flutter. 🎨✨",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "24 minutes ago",
                  style: GoogleFonts.roboto(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color hoverColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          IconButton(
            icon: Icon(icon, size: 26),
            onPressed: () {},
            visualDensity: VisualDensity.compact,
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w500),
            ),
        ],
      ),
    );
  }
}
