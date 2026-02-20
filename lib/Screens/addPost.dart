import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Widgets/button.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  final titleController = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Post",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                // Submit Logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: const Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (loading) const LinearProgressIndicator(),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("images/google.png"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "anshu_kr",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: titleController,
                          maxLines: null, // Auto-expanding
                          style: GoogleFonts.roboto(fontSize: 18),
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Image Placeholder / Upload Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  // Image Picking Logic
                },
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined, size: 50, color: primaryColor),
                      const SizedBox(height: 10),
                      Text(
                        "Add Photo/Video",
                        style: GoogleFonts.roboto(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Post Options Table
            const Divider(),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.green),
              title: const Text("Photo/Video"),
              onTap: () {},
            ),
            const Divider(height: 1, indent: 70),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text("Tag People"),
              onTap: () {},
            ),
            const Divider(height: 1, indent: 70),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.red),
              title: const Text("Add Location"),
              onTap: () {},
            ),
            const Divider(height: 1, indent: 70),
            ListTile(
              leading: const Icon(Icons.emoji_emotions, color: Colors.orange),
              title: const Text("Feeling/Activity"),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
