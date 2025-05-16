import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/pill_report_screen_aya.dart';
import 'package:mindpal/aya_file/widgets_aya/bottom_nav_bar_aya.dart';

class HomePage extends StatelessWidget {
  final List<String> patients = [
    'Ahmed Ali',
    'Salma Elsaid',
    'Ramy Sabry',
    'Amr Diab'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF18181B),
      bottomNavigationBar: BottomNavBar(selected: 0),
      body: SafeArea(
        child: Column(
          children: [
            // Calendar bar placeholder
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // ... Calendar widget here ...
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Patient Names',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  Text('${patients.length} Names',
                      style: TextStyle(color: Color(0xFFA892F5))),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) => Card(
                  color: Color(0xFF23232B),
                  child: ListTile(
                    title: Text(patients[index],
                        style: TextStyle(color: Colors.white)),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PillReportScreen(patientName: patients[index]),
                      ),
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
