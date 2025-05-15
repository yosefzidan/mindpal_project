import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const String routeName = "test";

  @override
  State<Test> createState() => _TestScreenState();
}

class _TestScreenState extends State<Test> {
  int selectedIndex = 1;

  final List<Widget> pages = [
    Center(child: Text('Doctors')),
    Center(child: Text('Home')),
    Center(child: Text('Patients')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 70, // خليت الارتفاع أكبر عشان الأيقونة الوسطانية
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(icon: Icons.medical_services_outlined,
                  label: 'Doctors',
                  index: 0),
              const SizedBox(width: 30), // مسافة للزرار اللي في النص
              buildNavItem(
                  icon: Icons.person_outline, label: 'Patients', index: 2),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () => _onItemTapped(1),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selectedIndex == 1 ? Colors.purpleAccent : Colors.grey,
          ),
          child: Icon(
            Icons.home_max_outlined,
            size: 35,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(
      {required IconData icon, required String label, required int index}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: selectedIndex == index ? Colors.purpleAccent : Colors.white,
            size: 25,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Colors.purpleAccent : Colors
                  .white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
