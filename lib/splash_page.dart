import 'package:flutter/material.dart';

// StatelessWidget for the SplashPage, which typically shows a logo or loading indicator.
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold provides a high-level structure to the UI, which in this case contains only a body.
    return Scaffold(
      body: Center(
        // Center widget centers its child within itself.
        child: Image.asset('assets/rqlogo.png'), // Loads and displays an image from the assets.
      ),
    );
  }
}
