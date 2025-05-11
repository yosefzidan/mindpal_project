import 'package:flutter/material.dart';
import 'package:mindpal/create_patientAccount.dart';
import 'package:mindpal/doctor_tab.dart';
import 'package:mindpal/home_tab.dart';
import 'package:mindpal/patient_tab.dart';

class HomeAdminScreen extends StatefulWidget {
  static const String routeName = "HomeAdminScreen";

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  int selectedIndex = 1;

  final List<Widget> pages = [DoctorTab(), HomeTab(), PatientTab()];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[selectedIndex],
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
              const SizedBox(width: 20),
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
