import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CancelGoalScreen extends StatelessWidget {
  final String goalTitle;
  // final dynamic goalImage;
  final DateTime? endDate;

  CancelGoalScreen({
    required this.goalTitle,
    //  required this.goalImage,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    // Bitime kalan süreyi hesapla
    final timeRemaining =
        endDate != null ? endDate!.difference(DateTime.now()) : Duration.zero;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Goal'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image.asset(goalImage), // Hedefin resmi
            Text(
              goalTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Time Remaining: ${timeRemaining.inDays} days',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
              onPressed: () {
                // Burada hedefi iptal etme işlemlerini gerçekleştirin
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
