import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/view_medicine_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowBottles extends StatefulWidget {
  static const String routeName = "ShowBottles";

  @override
  State<ShowBottles> createState() => _ShowBottlesState();
}

class _ShowBottlesState extends State<ShowBottles> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String? patientCode;
  String? patientId;
  Patients? patient;

  bool isLoading = true;
  List<Medicines> medicines = [];
  List<String> bottleNum = ['Motor1', 'Motor2', 'Motor3', 'Motor4', 'Motor5'];

  String convertTo24HourFormat(String time12h) {
    final format12h = DateFormat.jm();
    final format24h = DateFormat.Hm();
    DateTime dateTime = format12h.parse(time12h);
    return format24h.format(dateTime);
  }

  String getMedicineNameByBottle(String bottleNumber) {
    try {
      final med = medicines.firstWhere(
        (med) => med.numPottle == bottleNumber,
      );

      return med.name ?? 'empty';
    } catch (e) {
      return 'empty';
    }
  }

  String getMedicineAmountByBottle(String bottleNumber) {
    try {
      final med = medicines.firstWhere(
        (med) => med.numPottle == bottleNumber,
      );

      return med.dosage ?? '000';
    } catch (e) {
      return 'null';
    }
  }

  Medicines getMedicineNameByBottleM(String bottleNumber) {
    final med = medicines.firstWhere(
      (med) => med.numPottle == bottleNumber,
    );

    return med;
  }

  Future<void> loadPatients() async {
    if (patientId == null || patientId!.isEmpty) {
      print("❌ patientId is null or empty in loadPatients");
      return;
    }

    try {
      print("Loading patient with ID: $patientId");
      final fetchedPatient = await ApiManger.getPatientById(patientId!);

      setState(() {
        patient = fetchedPatient;

        List<Medicines> sortedMedicines = bottleNum
            .map((bottle) {
              try {
                return patient?.medicines
                    ?.firstWhere((med) => med.numPottle == bottle);
              } catch (e) {
                return null;
              }
            })
            .whereType<Medicines>()
            .toList();

        medicines = sortedMedicines;

        isLoading = false;

        print("Loaded medicines: ${medicines.length}");
        medicines.forEach((med) {
          print("Medicine name: ${med.name}, Bottle: ${med.numPottle}");
        });
      });
    } catch (e, stacktrace) {
      print("❌ Error fetching patients: $e");
      print("📌 Stacktrace: $stacktrace");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadPatientId(); // استدعاء الدالة بعد بناء الشاشة
  }

  Future<void> loadPatientId() async {
    final prefs = await SharedPreferences.getInstance();
    patientId = prefs.getString('userId');

    if (patientId != null) {
      await loadPatients();
    } else {
      print("❌ patientId not found in SharedPreferences");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xFFA27EFC),
              ),
            )
          : medicines.isEmpty
              ? Center(
                  child: Text(
                    'No medicines available at the momentً',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.1,
                          ),
                          TableCalendar(
                            daysOfWeekHeight: 30,
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: _focusedDay,
                            calendarFormat: _calendarFormat,
                            availableCalendarFormats: {
                              CalendarFormat.week: 'Week'
                            },
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
                              titleTextStyle: TextStyle(
                                  color: Color(0xFFD0D2D1), fontSize: 20),
                              leftChevronIcon:
                                  Icon(Icons.chevron_left, color: Colors.white),
                              rightChevronIcon: Icon(Icons.chevron_right,
                                  color: Colors.white),
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(color: Color(0xFFE6E6E6)),
                              weekendStyle: TextStyle(color: Color(0xFFE6E6E6)),
                            ),
                            calendarStyle: CalendarStyle(
                              outsideDaysVisible: false,
                              defaultTextStyle:
                                  TextStyle(color: Color(0xFFA6A6A6)),
                              weekendTextStyle:
                                  TextStyle(color: Color(0xFFA6A6A6)),
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
                            height: height * 0.06,
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
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFFD0D2D1)),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${medicines.length} bottles',
                                    style: TextStyle(
                                        fontSize: 18, color: Color(0xFFA27EFC)),
                                  ),
                                  SizedBox(width: width * 0.07),
                                ],
                              ),
                              SizedBox(height: height * 0.037),
                              SizedBox(
                                height: height * 0.42,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: medicines.length,
                                  itemBuilder: (context, index) {
                                    final med = medicines[index];
                                    final bottle = med.numPottle ?? 'Unknown';
                                    return InkWell(
                                      onTap: () async {
                                        await Navigator.pushNamed(
                                          context,
                                          ViewMedicineScreen.routeName,
                                          arguments: {
                                            'medicine':
                                                getMedicineNameByBottleM(
                                                    bottle),
                                          },
                                        );
                                        if (patientId != null) {
                                          await loadPatients();
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: width * 0.034),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF292929),
                                          border: Border.all(
                                              color: Color(0xFFA27EFC),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: width * 0.4,
                                        child: Column(
                                          children: [
                                            SizedBox(height: height * 0.02),
                                            Text(
                                              bottle,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xFFD0D2D1)),
                                            ),
                                            SizedBox(height: 8),
                                            Center(
                                                child: Image.asset(
                                                    'assets/images/U 1.png')),
                                            SizedBox(height: 8),
                                            Text(
                                              getMedicineNameByBottle(bottle),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '(${getMedicineAmountByBottle(bottle)})pills',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xFFD0D2D1)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
    );
  }
}
