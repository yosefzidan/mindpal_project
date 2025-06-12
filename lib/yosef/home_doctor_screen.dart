import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/bottles_screen_aya.dart';
import 'package:mindpal/aya_file/doctor_home_screen_aya.dart';
import 'package:mindpal/aya_file/home_page_aya.dart';
import 'package:mindpal/aya_file/widgets_aya/report_tab.dart';

class HomeDoctorScreen extends StatefulWidget {
  static const String routeName = "kkkkkkkkkkkkkk";

  @override
  State<HomeDoctorScreen> createState() => _HomeDoctorScreenState();
}

class _HomeDoctorScreenState extends State<HomeDoctorScreen> {
  int selectedIndex = 1;

  final List<Widget> pages = [
    HomePage(),
    DoctorHomeScreen(),
    ReportTab(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const purple = Color(0xFFA27AFC);
    const dark = Color(0xFF191919);

    return Scaffold(
      backgroundColor: dark,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: height * 0.14,
        color: dark,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                icon: Icons.medication_outlined,
                label: 'Pills',
                index: 0,
              ),
              buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 1,
              ),
              buildNavItem(
                icon: Icons.insert_chart_outlined,
                label: 'Reports',
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    const purple = Color(0xFFA892F5);
    final isSelected = selectedIndex == index;
    final isHome = index == 1;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 6),
          isHome
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: purple,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 26,
                  ),
                )
              : Icon(
                  icon,
                  color: isSelected ? purple : Colors.white54,
                ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? purple : Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
