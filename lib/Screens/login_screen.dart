import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monogram/Screens/home_screen.dart';
import 'package:monogram/Screens/signup_screen.dart';
import 'package:monogram/Toast/errorToast.dart';
import 'package:monogram/Widgets/button.dart';
import 'package:monogram/Widgets/social_media_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    auth
        .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.toString(),
        )
        .then((value) {
          setState(() {
            loading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        })
        .onError((error, errorStack) {
          setState(() {
            loading = false;
          });
          Errortoast().showToast(error.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Welcome", style: GoogleFonts.lobster(fontSize: 40)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Login Now",
                  style: GoogleFonts.lobster(fontSize: 20),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
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
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.password),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                      ),
                    ),
                    Button(
                      title: "Login",
                      loading: loading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(child: Text("Don't have an account?")),
                        Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupScreen(),
                                ),
                              );
                            },
                            child: const Text(" Create Now"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        const Text("Or"),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
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
                    const SizedBox(height: 20),
                    const SocialMediaLogin(),
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
