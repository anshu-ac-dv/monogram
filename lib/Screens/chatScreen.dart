import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Messages",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_note_rounded, color: isDark ? Colors.white : Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search messages...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Colors.grey.shade500),
                ),
              ),
            ),
          ),

          // Active Now Section
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 8,
              itemBuilder: (context, index) {
                return _buildActiveUser(index, isDark);
              },
            ),
          ),

          const SizedBox(height: 10),

          // Chats List
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900.withOpacity(0.5) : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 100),
                physics: const BouncingScrollPhysics(),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return _buildChatTile(index, isDark, primaryColor);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveUser(int index, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                backgroundImage: const AssetImage("images/google.png"),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: isDark ? Colors.black : Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "User $index",
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(int index, bool isDark, Color primaryColor) {
    bool isUnread = index % 3 == 0;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: primaryColor.withOpacity(0.1),
        backgroundImage: const AssetImage("images/google.png"),
      ),
      title: Text(
        "Friend Name $index",
        style: TextStyle(
          fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        "The message preview goes here...",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isUnread ? (isDark ? Colors.white : Colors.black87) : Colors.grey,
          fontWeight: isUnread ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "12:45 PM",
            style: TextStyle(
              fontSize: 12,
              color: isUnread ? Colors.blueAccent : Colors.grey,
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                shape: BoxShape.circle,
              ),
              child: const Text(
                "1",
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      onTap: () {},
    );
  }
}
