import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  // Dummy data for chat list

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("Messages", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_note_rounded)),
        ],
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(Icons.person, color: primaryColor),
            ),
            title: Text("User ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Hey, how are you?"),
            trailing: const Text("12:30 PM", style: TextStyle(fontSize: 12, color: Colors.grey)),
          );
        },
      ),
    );
  }
}
