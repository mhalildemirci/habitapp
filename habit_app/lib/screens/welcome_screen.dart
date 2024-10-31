import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'goal_selection_screen.dart'; // GoalSelectionScreen dosyasını dahil ediyoruz.

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/startpic.svg', // SVG dosya yolu
              width: 150, // İsteğe bağlı boyutlandırma
              height: 150, // İsteğe bağlı boyutlandırma
            ),
            SizedBox(height: 20),
            Text(
              'Track Productivity & Healthy Habits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            // Let's Start butonu, linear gradient ile süslenmiş
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D31FF), Color(0xFF00C3F9)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Butona tıklanınca GoalSelectionScreen'e yönlendirme
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GoalSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Text(
                  "Let's Start",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
