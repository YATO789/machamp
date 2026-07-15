import 'package:flutter/material.dart';

class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key, this.size = 24.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/google_logo.webp',
      width: size,
      height: size,
    );
  }
}
