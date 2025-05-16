import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/edit_user_screen_aya.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  final List<String> patients = [
    'Ahmed Ali',
    'Salma Elsaid',
    'Ramy Sabry',
    'Amr Diab',
  ];

  int selectedDay = 8;
  int selectedMonth = 1;
  int selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    final purple = const Color(0xFFA892F5);
    final dark = const Color(0xFF18181B);
    return Scaffold(
      backgroundColor: dark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white70,
                        size: 18,
                      ),
                      Text(
                        'January $selectedYear',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                      final dayNum = 6 + index; // 6-12
                      final isSelected = dayNum == selectedDay;
                      return Column(
                        children: [
                          Text(
                            days[index],
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Inter',
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () => setState(() => selectedDay = dayNum),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isSelected ? purple : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '$dayNum',
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white38,
                  ),
                ],
              ),
            ),
            // Patient Names Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Patient Names',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '${patients.length} Names',
                    style: TextStyle(
                      color: purple,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            // Patient List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: purple, width: 1.2),
                      borderRadius: BorderRadius.circular(12),
                      color: dark,
                    ),
                    child: ListTile(
                      title: Text(
                        patients[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline, color: purple),
                        onPressed: () {
                          setState(() {
                            patients.removeAt(index);
                          });
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => EditUserScreen(
                              userData: {
                                'name': patients[index],
                                'gender': 'Male',
                                'age': '70',
                                'alzStage': 'The Third Stage',
                                'amount': '40 pill',
                                'pillsPerDay': '2 pills',
                                'pillTime': TimeOfDay(hour: 10, minute: 30),
                                'hoursApart': 'Every 2 hours',
                                'takingInterval': 'Every 3 days',
                                'startDate': DateTime(2025, 1, 8),
                                'endDate': DateTime(2025, 4, 8),
                              },
                              onSave: (updatedUser) {
                                // Handle save logic here
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            // Space for bottom nav bar
            const SizedBox(height: 80),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        color: dark,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.medication_outlined, color: Colors.white54),
                const SizedBox(height: 4),
                const Text(
                  'Pills',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: purple,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.home_rounded, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  'Home',
                  style: TextStyle(
                    color: purple,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.insert_chart_outlined, color: Colors.white54),
                const SizedBox(height: 4),
                const Text(
                  'Reports',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
