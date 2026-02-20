import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final List<String> _categories = [
    "For You",
    "Trending",
    "Photography",
    "Nature",
    "Travel",
    "Architecture",
    "Art",
    "Food"
  ];

  final TextEditingController searchController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    Color primaryColor = Colors.blueAccent;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {}); // Rebuild to update the search query
            },
            decoration: InputDecoration(
              hintText: "Search Monogram Users...",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14), // Adjusted padding
            ),
          ),
        ),
      ),
      body: searchController.text.isEmpty
          ? _buildExploreContent(isDark, primaryColor)
          : _buildSearchResults(),
    );
  }

  Widget _buildSearchResults() {
    return FirebaseAnimatedList(
      query: ref.orderByChild('name').startAt(searchController.text).endAt("${searchController.text}\uf8ff"),
      itemBuilder: (context, snapshot, animation, index) {
        if (!snapshot.exists) {
          return const Center(child: Text("No user found"));
        }

        final email = snapshot.child('email').value.toString();
        final name = snapshot.child('name').value.toString();

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'U'),
          ),
          title: Text(name),
          subtitle: Text(email),
          onTap: () {
            // TODO: Navigate to user profile screen
          },
        );
      },
    );
  }

  Widget _buildExploreContent(bool isDark, Color primaryColor) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Categories Horizontal List
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: index == 0 ? primaryColor : (isDark ? Colors.grey.shade900 : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: index == 0 ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Explore Grid
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20, // Dummy count
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.grey.shade200,
                    image: const DecorationImage(
                      image: AssetImage("images/x.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: index % 7 == 0
                      ? const Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.collections, color: Colors.white, size: 18),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
