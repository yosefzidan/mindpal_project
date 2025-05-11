import 'package:flutter/material.dart';
import 'package:mindpal/add_medicine_name.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseBottles extends StatefulWidget {
  static const String routeName = "ChooseBottles";

  @override
  State<ChooseBottles> createState() => _TestScreenState();
}

class _TestScreenState extends State<ChooseBottles> {
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
          Column(
            children: [
              TableCalendar(
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
              SizedBox(
                height: height * 0.074,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'bills bottles',
                      style: TextStyle(fontSize: 24, color: Color(0xFFD0D2D1)),
                    ),
                    Spacer(),
                    Text(
                      '5 bottles',
                      style: TextStyle(fontSize: 8, color: Color(0xFFA27EFC)),
                    ),
                    SizedBox(
                      width: width * 0.07,
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.037,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AddMedicineName.routeName);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: width * 0.034),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFFA27EFC), width: 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: height * 0.4,
                          width: width * 0.31,
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.033,
                              ),
                              Text(
                                'first pill bottle',
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFFD0D2D1)),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Center(
                                  child: Image.asset('assets/images/U 1.png')),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                'empty',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                '(0)pills',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFFD0D2D1)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: width * 0.034),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFA27EFC), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: height * 0.4,
                        width: width * 0.31,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Text(
                              'first pill bottle',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFD0D2D1)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(child: Image.asset('assets/images/U 1.png')),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'empty',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '(0)pills',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFD0D2D1)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: width * 0.034),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFA27EFC), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: height * 0.4,
                        width: width * 0.31,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Text(
                              'first pill bottle',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFD0D2D1)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(child: Image.asset('assets/images/U 1.png')),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'empty',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '(0)pills',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFD0D2D1)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: width * 0.034),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFA27EFC), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: height * 0.4,
                        width: width * 0.31,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Text(
                              'first pill bottle',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFD0D2D1)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(child: Image.asset('assets/images/U 1.png')),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'empty',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '(0)pills',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFD0D2D1)),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: width * 0.034),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xFFA27EFC), width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        height: height * 0.4,
                        width: width * 0.31,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Text(
                              'first pill bottle',
                              style: TextStyle(
                                  fontSize: 10, color: Color(0xFFD0D2D1)),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(child: Image.asset('assets/images/U 1.png')),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'empty',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              '(0)pills',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFD0D2D1)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
