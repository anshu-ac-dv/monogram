import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final TextEditingController _messageController = TextEditingController();

  // Dummy messages for design purposes
  final List<Map<String, dynamic>> _messages = [
    {"text": "Hey there! How's the app coming along?", "isMe": false, "time": "10:00 AM"},
    {"text": "It's going great! Just finished the chat UI.", "isMe": true, "time": "10:01 AM"},
    {"text": "That's awesome! Does it support dark mode?", "isMe": false, "time": "10:02 AM"},
    {"text": "Yes, absolutely! Everything is dynamic.", "isMe": true, "time": "10:02 AM"},
    {"text": "Can I see a demo?", "isMe": false, "time": "10:05 AM"},
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 1,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: const AssetImage("images/google.png"),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anshu Kr",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Online",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.videocam_outlined), onPressed: () {}),
          IconButton(icon: const Icon(Icons.call_outlined), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return MessageBubble(
                  text: msg['text'],
                  isMe: msg['isMe'],
                  time: msg['time'],
                  isDark: isDark,
                  primaryColor: primaryColor,
                );
              },
            ),
          ),
          
          // Message Input Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade900 : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add, color: primaryColor),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.black : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({
                            "text": _messageController.text,
                            "isMe": true,
                            "time": "10:10 AM"
                          });
                          _messageController.clear();
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: const Icon(Icons.send, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String time;
  final bool isDark;
  final Color primaryColor;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    required this.time,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe 
                ? primaryColor 
                : (isDark ? Colors.grey.shade800 : Colors.white),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isMe ? 16 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 16),
              ),
              boxShadow: [
                if (!isMe)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: isMe ? Colors.white : (isDark ? Colors.white : Colors.black87),
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
