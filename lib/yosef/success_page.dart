import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SuccessPage extends StatefulWidget {
  static const String routeName = "successPage";

  @override
  State<SuccessPage> createState() => _TestScreenState();
}

class _TestScreenState extends State<SuccessPage> {
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
      body: Column(
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
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
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
                  color: Color(0xFFA27AFC),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.11,
          ),
          Center(child: Image.asset('assets/images/Mask Group 2.png')),
          SizedBox(
            height: 8,
          ),
          Center(
              child: Text(
            'The account for your patient has been \n                        created.',
            style: TextStyle(color: Color(0xFFD0D2D1), fontSize: 18),
          )),
          Spacer(),
          Center(
            child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(
                      right: width * 0.15,
                      left: width * 0.15,
                      top: width * 0.03,
                      bottom: width * 0.03),
                  child: Text('Next'),
                )),
          ),
          SizedBox(
            height: height * 0.15,
          )
        ],
      ),
    );
  }
}
