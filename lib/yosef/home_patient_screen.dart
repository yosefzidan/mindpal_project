import 'package:flutter/material.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/home_patient.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:mindpal/yosef/show_bottles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePatientScreen extends StatefulWidget {
  static const String routeName = "HomePatientScreen";

  @override
  State<HomePatientScreen> createState() => _HomePatientScreenState();
}

class _HomePatientScreenState extends State<HomePatientScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 1;

  final List<Widget> pages = [
    ShowBottles(),
    HomePatient(),
    Placeholder(),
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
    const dark = Color(0xff191919);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: dark,
      drawer: Container(
        width: width * 0.6,
        color: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: purple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                await prefs.remove('role');
                await prefs.remove('userId');

                ApiConstants.Token = '';

                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          pages[selectedIndex],
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
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
                  icon: Icons.medication_outlined, label: 'Pills', index: 0),
              buildNavItem(icon: Icons.home_rounded, label: 'Home', index: 1),
              buildNavItem(
                  icon: Icons.insert_chart_outlined,
                  label: 'Reports',
                  index: 2),
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
                  child: Icon(icon, color: Colors.white, size: 26),
                )
              : Icon(icon, color: isSelected ? purple : Colors.white54),
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
