import 'package:flutter/material.dart';
import 'monogram_logo.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset("images/google.png", height: 50),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            "images/facebook.png",
            height: 50,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const MonogramLogo(
            size: 45,
            borderRadius: 12,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
