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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text("Suggested post for you", style: GoogleFonts.oswald(fontSize: 20)),
      ),
    );
  }
}
