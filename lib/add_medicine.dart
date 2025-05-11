import 'package:flutter/material.dart';
import 'package:mindpal/choose_bottles.dart';
import 'package:table_calendar/table_calendar.dart';

class AddMedicine extends StatefulWidget {
  static const String routeName = "AddMedicine";

  @override
  State<AddMedicine> createState() => _TestScreenState();
}

class _TestScreenState extends State<AddMedicine> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                daysOfWeekHeight: 30,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                availableCalendarFormats: {CalendarFormat.week: 'Week'},
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
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
            SizedBox(
              height: height * 0.09,
            ),
            Center(child: Image.asset('assets/images/Group 26780.png')),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Add medicaments into your five bottles\nto receive notifications about the receptions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFD0D2D1),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Image.asset('assets/images/Frame.png'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, ChooseBottles.routeName);
              },
              backgroundColor: Color(0xFF825DDE),
              elevation: 10,
              shape: CircleBorder(),
              child: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: height * 0.13,
            )
          ],
        ),
      ),
    );
  }
}
