import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonogramLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double fontSize;

  const MonogramLogo({
    super.key,
    this.size = 80,
    this.borderRadius = 25,
    this.fontSize = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF405DE6),
            Color(0xFF5851DB),
            Color(0xFF833AB4),
            Color(0xFFC13584),
            Color(0xFFE1306C),
            Color(0xFFFD1D1D),
            Color(0xFFF56040),
            Color(0xFFF77737),
            Color(0xFFFCAF45),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF833AB4).withValues(alpha: 0.3),
            blurRadius: size / 4,
            offset: Offset(0, size / 8),
          ),
        ],
      ),
      child: Text(
        "M",
        style: GoogleFonts.lobster(
          fontSize: fontSize,
          color: Colors.white,
          height: 1.1,
        ),
      ),
    );
  }
}
