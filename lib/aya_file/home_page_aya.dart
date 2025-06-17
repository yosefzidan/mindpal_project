import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/choose_bottle_update.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<Patients> patients = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  Future<void> loadPatients() async {
    try {
      print("load patients: ");
      final fetchedPatients = await ApiManger.getAllPatients();
      setState(() {
        patients = fetchedPatients;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching patients: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load patients")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final purple = const Color(0xFFA892F5);
    final dark = const Color(0xFF191919);
    return Scaffold(
      backgroundColor: Color(0xFF191919),
      body: SafeArea(
        child: Column(
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
                  height: height * 0.02,
                ),
              ],
            ),

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
            isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Colors.deepPurple))
                : patients.isEmpty
                    ? Center(
                        child: Text("No Patients found",
                            style: AppStyle.gray16400))
                    : Expanded(
              child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            itemCount: patients.length,
                            itemBuilder: (context, index) {
                              final patient = patients[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ChooseBottleUpdate.routeName,
                                      arguments: {
                                        'patientCode': patient.code,
                                        'patientId': patient.id,
                                      });
                                },
                                child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: purple, width: 1.2),
                                      borderRadius: BorderRadius.circular(12),
                                      color: dark,
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        patient.name ?? 'null',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                    )),
                              );
                            }),
            ),
          ],
        ),
      ),
    );
  }
}
