import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheet/Screens/AddWork.dart';
import 'package:sheet/Screens/ViewWork.dart';

final TextStyle welcomeStyle = GoogleFonts.lato(fontSize: 22);

class HomePage extends StatelessWidget {
  static String id = 'HomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(fontSize: 36),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AddWork.id);
                },
                child: Container(
                  width: 400, // Increase the width for desktop
                  padding: const EdgeInsets.symmetric(
                      vertical: 30), // Increase the padding
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8BC34A),
                        Color(0xFF4CAF50)
                      ], // Use a gradient
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Add Work',
                      style: TextStyle(
                        fontSize: 28, // Increase the font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Increase the spacing
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ViewWork.id);
                },
                child: Container(
                  width: 400, // Increase the width for desktop
                  padding: const EdgeInsets.symmetric(
                      vertical: 30), // Increase the padding
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFE91E63),
                        Color(0xFFC2185B)
                      ], // Use a gradient
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'View Work',
                      style: TextStyle(
                        fontSize: 28, // Increase the font size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
