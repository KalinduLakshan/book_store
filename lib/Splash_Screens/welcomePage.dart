import 'package:book_store/pages/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class WelcomePage extends StatefulWidget {
  WelcomePage(BuildContext context);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Setup animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    // Start a timer for 6 seconds, after which navigate to the home page
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image with curved bottom
          ClipPath(
            clipper: BottomWaveClipper(), // Custom clipper for the bottom wave
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.8, // Adjust height as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/john-michael-thomson-9m1V6A8Fm-A-unsplash.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // App name with fade animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: const Text(
              'Book Store',
              style: TextStyle(
                fontFamily: 'Cursive',
                color: Color.fromARGB(255, 131, 10, 1),
                fontSize: 50,
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

// Custom clipper for the bottom curve
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start from bottom-left
    path.lineTo(0, size.height);

    // Curve starts from the bottom-left corner and curves upwards
    var controlPoint = Offset(size.width / 2, size.height - 100);
    var endPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    // Close the path by drawing the top line
    path.lineTo(size.width, 0);
    path.lineTo(0.0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
