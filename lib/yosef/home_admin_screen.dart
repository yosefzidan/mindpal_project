import 'package:flutter/material.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/doctor_tab.dart';
import 'package:mindpal/yosef/home_tab.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:mindpal/yosef/patient_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdminScreen extends StatefulWidget {
  static const String routeName = "HomeAdminScreen";

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  int selectedIndex = 1;
  final List<Widget> pages = [DoctorTab(), HomeTab(), PatientTab()];
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // لتتحكم في فتح الـ Drawer

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      drawer: Container(
        width: width * 0.6, // تخلي الدروار تلتين أو أقل
        color: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF825DDA)),
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
                ApiConstants.Token = '';

                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName, //  LoginScreen.routeName
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

          // زر القائمة الجانبية في الزاوية
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
                  color: Color(0xFF292929),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 15,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                  image: AssetImage('assets/images/icon-doctor-regular.png'),
                  label: 'Doctors',
                  index: 0),
              SizedBox(width: width * 0.25),
              buildNavItem(
                  image: AssetImage('assets/images/icon-patient-regular.png'),
                  label: 'Patients',
                  index: 2),
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
            color: selectedIndex == 1 ? Color(0xFF825DDA) : Color(0xFF825DDA),
          ),
          child: ImageIcon(
            AssetImage('assets/images/shop.png'),
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(
      {required AssetImage image, required String label, required int index}) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageIcon(
            image,
            size: 24,
            color: selectedIndex == index ? Color(0xFF825DDA) : Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: selectedIndex == index ? Color(0xFF825DDA) : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
