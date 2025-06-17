import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/aya_file/edit_user_screen_aya.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseBottleUpdate extends StatefulWidget {
  static const String routeName = "ChooseBottleUpdate";

  @override
  State<ChooseBottleUpdate> createState() => _ChooseBottleUpdateState();
}

class _ChooseBottleUpdateState extends State<ChooseBottleUpdate> {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      patientCode = args['patientCode']?.toString();
      patientId = args['patientId']?.toString();
      print("patientId from arguments: $patientId");
    }

    if (patientId != null && patientId!.isNotEmpty) {
      loadPatients();
    } else {
      print("❌ patientId is null or empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
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
                                    style: TextStyle(
                                        fontSize: 24, color: Color(0xFFD0D2D1)),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${medicines.length} bottles',
                                    style: TextStyle(
                                        fontSize: 8, color: Color(0xFFA27EFC)),
                                  ),
                                  SizedBox(width: width * 0.07),
                                ],
                              ),
                              SizedBox(height: height * 0.037),
                              SizedBox(
                                height: height * 0.4,
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
                                          EditUserScreen.routeName,
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
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        width: width * 0.31,
                                        child: Column(
                                          children: [
                                            SizedBox(height: height * 0.033),
                                            Text(
                                              bottle,
                                              style: TextStyle(
                                                  fontSize: 10,
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
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '(0)pills',
                                              style: TextStyle(
                                                  fontSize: 12,
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
