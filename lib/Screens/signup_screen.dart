import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/home_screen.dart';
import 'package:monogram/Screens/login_screen.dart';
import 'package:monogram/Toast/errorToast.dart';
import 'package:monogram/Widgets/button.dart';
import 'package:monogram/Widgets/social_media_login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void register() {
    setState(() {
      loading = true;
    });
    auth
        .createUserWithEmailAndPassword(
          email: emailController.text
              .trim(), // Added trim() to avoid whitespace errors
          password: passwordController.text.toString(),
        )
        .then((onValue) {
          setState(() {
            loading = false;
          });
          Errortoast().SuccessToast("Register Successfully");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        })
        .onError((error, stackTrace) {
          Errortoast().showToast(error.toString());
          setState(() {
            loading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Added scroll view to prevent overflow
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
                  "Register Now",
                  style: GoogleFonts.lobster(fontSize: 20),
                ),
              ),
              Form(
                key: _formKey, // CRITICAL: Added the form key here
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true, // Hide password text
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.password),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Button(
                      title: "Register",
                      loading: loading, // Pass loading state to show spinner
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          register();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            " Login Now",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // ... rest of your UI (Dividers and Social Login)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("images/google.png", height: 50),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              "images/facebook.png",
                              height: 50,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset("images/x.png", height: 50),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
