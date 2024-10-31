import 'package:flutter/material.dart';
import 'goal_date_selection_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  @override
  _GoalSelectionScreenState createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  // Seçilen hedefler ve ikonları için bir liste
  final List<Map<String, dynamic>> goals = [
    {'title': 'Running', 'icon': Icons.directions_run, 'color': Colors.blue},
    {'title': 'Reading', 'icon': Icons.book, 'color': Colors.purple},
    {'title': 'Smoking', 'icon': Icons.smoke_free, 'color': Colors.green},
    {'title': 'Alcohol', 'icon': Icons.local_bar, 'color': Colors.orange},
    {'title': 'Fitness', 'icon': Icons.fitness_center, 'color': Colors.amber},
    {'title': 'Pornography', 'icon': Icons.explicit, 'color': Colors.red},
  ];

  final List<Map<String, dynamic>> selectedGoals = [];

  void toggleGoalSelection(Map<String, dynamic> goal) {
    setState(() {
      if (selectedGoals.contains(goal)) {
        selectedGoals.remove(goal);
      } else {
        selectedGoals.add(goal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'What goals you want to focus on',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  final isSelected = selectedGoals.contains(goal);

                  return GestureDetector(
                    onTap: () => toggleGoalSelection(goal),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? goal['color'].withOpacity(0.1)
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color:
                              isSelected ? goal['color'] : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(goal['icon'], color: goal['color'], size: 40),
                          SizedBox(height: 10),
                          Text(
                            goal['title'],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
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
                  onPressed: () {
                    // Butona tıklanınca GoalSelectionScreen'e yönlendirme
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoalDateSelectionScreen(
                            selectedGoals: selectedGoals),
                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}
