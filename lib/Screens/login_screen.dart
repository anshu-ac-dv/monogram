import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/signup_screen.dart';
import 'package:monogram/Widgets/button.dart';
import 'package:monogram/Widgets/social_media_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Welcome",
                style: GoogleFonts.lobster(fontSize: 40),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Login Now",
                style: GoogleFonts.lobster(fontSize: 20),
              ),
            ),
            Form(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                  Button(title: "Login", onPressed: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: Text("Don't have an account?")),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: Text(" Create Now"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Divider(
                            color: Colors.grey.shade900,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Text("Or"),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Divider(
                            color: Colors.grey.shade900,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SocialMediaLogin(),
                  SizedBox(height: 80,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
