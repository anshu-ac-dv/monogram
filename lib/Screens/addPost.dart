import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post", style: GoogleFonts.lobster(fontSize: 30)),
        centerTitle: true,
      ),
    );
  }
}
