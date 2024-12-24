import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit_app/screens/cancel_goal_screen.dart';
import 'package:intl/intl.dart';

String _formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}

class HomeScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedGoals;
  final Map<String, DateTime?> startDates;
  final Map<String, DateTime?> endDates;

  HomeScreen({
    required this.selectedGoals,
    required this.startDates,
    required this.endDates,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _showMenu() {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          100, MediaQuery.of(context).size.height - 180, 100, 100),
      items: [
        PopupMenuItem(
          value: 'dark_mode',
          child: Row(
            children: [
              Icon(Icons.dark_mode, color: Color(0xFF04CBFC)),
              SizedBox(width: 8),
              Text('Dark Mode'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person, color: Color(0xFF04CBFC)),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'settings',
          child: Row(
            children: [
              Icon(Icons.settings, color: Color(0xFF04CBFC)),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'dark_mode') {
        // Dark mode action
      } else if (value == 'profile') {
        // Profile action
      } else if (value == 'settings') {
        // Settings action
      }
    });
  }

  Timer? _timer;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double _calculateProgress(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return 0.0;
    final totalDuration = endDate.difference(startDate).inSeconds;
    final elapsed = DateTime.now().difference(startDate).inSeconds;
    return (elapsed / totalDuration).clamp(0.0, 1.0);
  }

  String _formatRemainingTime(DateTime? endDate) {
    if (endDate == null) return 'Ended';
    final remaining = endDate.difference(DateTime.now());
    if (remaining.isNegative) return 'Ended';
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    return '${days}d ${hours}h remaining';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Statistics
              Text(
                'Progress Statistics',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                children: widget.selectedGoals.map((goal) {
                  final progress = _calculateProgress(
                    widget.startDates[goal['title']],
                    widget.endDates[goal['title']],
                  );
                  return GestureDetector(
                    // Hedef kartına tıklandığında CancelGoalScreen'e yönlendirme
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CancelGoalScreen(
                            goalTitle: goal['title'],
                            //goalImage: goal[goal], // Burada görsel yolunu geçin
                            endDate: widget.endDates[goal['title']],
                          ),
                        ),
                      );
                    },

                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: goal['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(goal['icon'],
                                  color: goal['color'], size: 30),
                              SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Start: ${widget.startDates[goal['title']] != null ? _formatDate(widget.startDates[goal['title']]!) : 'N/A'}\nEnd: ${widget.endDates[goal['title']] != null ? _formatDate(widget.endDates[goal['title']]!) : 'N/A'}',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  Text(
                                    _formatRemainingTime(
                                        widget.endDates[goal['title']]),
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progress,
                                color: goal['color'],
                                backgroundColor: goal['color'].withOpacity(0.3),
                              ),
                              Text('${(progress * 100).toInt()}%'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Daily Motivation Cards
              Text(
                'Daily Motivation Cards',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildMotivationCard(
                      'What is the 21 Day rule', 'assets/goalpic.svg'),
                  _buildMotivationCard(
                      '6 Golden rules of not giving up', 'assets/thinkpic.svg'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          child: Container(
            width: 205,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavButton(Icons.menu, 0),
                _buildNavButton(Icons.home, 1),
                _buildNavButton(Icons.add_circle_outline, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // Menü simgesine tıklandığında `_showMenu` fonksiyonunu çağırıyoruz.
        if (index == 0) {
          _showMenu();
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Color(0xFF04CBFC) : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Color(0xFF04CBFC),
        ),
      ),
    );
  }

  Widget _buildMotivationCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imagePath, width: 60, height: 60),
          SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: Text("Read More"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
