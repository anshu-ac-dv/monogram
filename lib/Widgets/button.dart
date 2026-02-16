import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final bool loading;
  final String title;
  final VoidCallback onPressed;
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: loading
                ? CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.black,
            )
                : Text(
              title,
              style: GoogleFonts.oswald(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}