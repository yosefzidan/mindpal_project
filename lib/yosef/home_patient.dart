import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePatient extends StatefulWidget {
  static const String routeName = "HomePatient";

  @override
  State<HomePatient> createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // 🔹 لإدارة الـ Drawer

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const purple = Color(0xFFA27AFC);
    const dark = Colors.black;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: dark,

      // ✅ Drawer الجانبي
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
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.09),
                Container(
                  child: TableCalendar(
                    daysOfWeekHeight: 30,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    availableCalendarFormats: {CalendarFormat.week: 'Week'},
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle:
                          TextStyle(color: Color(0xFFD0D2D1), fontSize: 20),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: Colors.white),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Color(0xFFE6E6E6)),
                      weekendStyle: TextStyle(color: Color(0xFFE6E6E6)),
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      defaultTextStyle: TextStyle(color: Color(0xFFA6A6A6)),
                      weekendTextStyle: TextStyle(color: Color(0xFFA6A6A6)),
                      selectedDecoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: Color(0xFFA27AFC),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.09),
                      Center(
                          child: Image.asset('assets/images/Group 26780.png')),
                      Text(
                        'You have successfully logged in. You will be notified about your medication schedule as soon as your doctor adds your schedule',
                        textAlign: TextAlign.center,
                        style: AppStyle.gray18400,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          // ✅ زر فتح Drawer
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
    );
  }
}
