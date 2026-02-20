import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  // Dummy data for chat list
  final List<Map<String, dynamic>> _chatList = [
    {
      "name": "Anshu Kumar",
      "lastMsg": "Hey! How is the project going?",
      "time": "10:30 AM",
      "unread": 2,
      "isOnline": true,
      "image": "images/google.png"
    },
    {
      "name": "Flutter Dev",
      "lastMsg": "Check out the new UI design.",
      "time": "Yesterday",
      "unread": 0,
      "isOnline": false,
      "image": "images/x.png"
    },
    {
      "name": "Firebase Team",
      "lastMsg": "Database updated successfully.",
      "time": "Monday",
      "unread": 5,
      "isOnline": true,
      "image": "images/google.png"
    },
    {
      "name": "Design Guru",
      "lastMsg": "Colors look amazing!",
      "time": "2:15 PM",
      "unread": 0,
      "isOnline": true,
      "image": "images/x.png"
    },
    {
      "name": "Monogram Support",
      "lastMsg": "Welcome to our platform.",
      "time": "12/10/23",
      "unread": 1,
      "isOnline": false,
      "image": "images/google.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Messages",
          style: GoogleFonts.roboto(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_note_rounded, color: primaryColor, size: 30),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search messages...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Active Users Row (Stories style)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _chatList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                              radius: 28,
                              backgroundImage: AssetImage(_chatList[index]['image']),
                            ),
                          ),
                          if (_chatList[index]['isOnline'])
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 14,
                                height: 14,
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
                        _chatList[index]['name'].split(' ')[0],
                        style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const Divider(height: 1),

          // Chat List
          Expanded(
            child: ListView.separated(
              itemCount: _chatList.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Divider(height: 1),
              ),
              itemBuilder: (context, index) {
                final chat = _chatList[index];
                return ListTile(
                  onTap: () {
                    // Navigate to individual chat screen
                  },
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(chat['image']),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat['name'],
                        style: GoogleFonts.roboto(
                          fontWeight: chat['unread'] > 0 ? FontWeight.bold : FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        chat['time'],
                        style: TextStyle(
                          color: chat['unread'] > 0 ? primaryColor : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chat['lastMsg'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: chat['unread'] > 0 
                                ? (isDark ? Colors.white : Colors.black) 
                                : Colors.grey,
                            fontWeight: chat['unread'] > 0 ? FontWeight.w500 : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (chat['unread'] > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat['unread'].toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
