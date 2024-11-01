import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedGoals;
  final Map<String, DateTime?> startDates;
  final Map<String, DateTime?> endDates;

  HomeScreen(
      {required this.selectedGoals,
      required this.startDates,
      required this.endDates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Goals Overview')),
      body: SingleChildScrollView(
        // Taşma sorununu önlemek için
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Goals',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true, // Yüksekliği sınırlamak için
                physics:
                    NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
                itemCount: selectedGoals.length,
                itemBuilder: (context, index) {
                  final goal = selectedGoals[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(goal['icon'], color: goal['color']),
                      title: Text(goal['title']),
                      subtitle: Text(
                        'Start: ${startDates[goal['title']]?.toLocal()}\nEnd: ${endDates[goal['title']]?.toLocal()}',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
