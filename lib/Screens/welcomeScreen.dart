import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/login_screen.dart';
import 'package:monogram/Screens/signup_screen.dart';
import 'package:monogram/Widgets/button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -size.width * 0.2,
            right: -size.width * 0.2,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -size.width * 0.3,
            left: -size.width * 0.3,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  
                  // Animated-like Logo Container
                  TweenAnimationBuilder(
                    duration: const Duration(seconds: 1),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue, Colors.blueAccent.shade700],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.blur_on,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Text Content
                  Text(
                    "Monogram",
                    style: GoogleFonts.lobster(
                      fontSize: 56,
                      color: isDark ? Colors.white : Colors.blueAccent.shade700,
                      letterSpacing: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  Text(
                    "Connect • Share • Inspire",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent.withOpacity(0.8),
                      letterSpacing: 2,
                    ),
                  ),
                  
                  const Spacer(flex: 1),
                  
                  Text(
                    "The simplest way to stay connected with your world. Join the community today.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: isDark ? Colors.white70 : Colors.black54,
                      height: 1.6,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  
                  const Spacer(flex: 2),
                  
                  // Bottom Buttons Section
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          title: "GET STARTED",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
