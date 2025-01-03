import 'package:flutter/material.dart';
import 'package:habit_app/screens/HomeScreen.dart';

class GoalDateSelectionScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedGoals;

  GoalDateSelectionScreen({required this.selectedGoals});

  @override
  _GoalDateSelectionScreenState createState() =>
      _GoalDateSelectionScreenState();
}

class _GoalDateSelectionScreenState extends State<GoalDateSelectionScreen> {
  final Map<String, DateTime?> startDates = {};
  final Map<String, DateTime?> endDates = {};

  Future<void> selectDate(
      BuildContext context, bool isStart, String goalTitle) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDates[goalTitle] = picked;

          // Başlangıç tarihinden önceki bitiş tarihini temizle
          if (endDates[goalTitle] != null &&
              endDates[goalTitle]!.isBefore(picked)) {
            endDates[goalTitle] = null;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "Bitiş tarihi başlangıç tarihinden sonra olmalıdır")),
            );
          }
        } else {
          // Bitiş tarihinin başlangıç tarihinden sonra olduğundan emin olun
          if (startDates[goalTitle] != null &&
              picked.isBefore(startDates[goalTitle]!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "Bitiş tarihi başlangıç tarihinden sonra olmalıdır")),
            );
          } else {
            endDates[goalTitle] = picked;
          }
        }
      });
    }
  }

  void _startGoal() {
    // Başlangıç ve bitiş tarihlerinin seçildiğinden emin olun
    bool allDatesSelected = widget.selectedGoals.every((goal) =>
        startDates[goal['title']] != null && endDates[goal['title']] != null);

    if (allDatesSelected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            selectedGoals: widget.selectedGoals,
            startDates: startDates,
            endDates: endDates,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Lütfen tüm başlangıç ve bitiş tarihlerini seçiniz")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Now, select starting date',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedGoals.length,
                itemBuilder: (context, index) {
                  final goal = widget.selectedGoals[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(goal['icon'], color: goal['color']),
                        title: Text(
                          goal['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Choose a start and end date"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () =>
                                selectDate(context, true, goal['title']),
                            child: Text(
                              startDates[goal['title']] != null
                                  ? 'Start: ${startDates[goal['title']]!.toLocal()}'
                                  : 'Select Start Date',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                selectDate(context, false, goal['title']),
                            child: Text(
                              endDates[goal['title']] != null
                                  ? 'End: ${endDates[goal['title']]!.toLocal()}'
                                  : 'Select End Date',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D31FF), Color(0xFF00C3F9)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: _startGoal,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Finished",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
