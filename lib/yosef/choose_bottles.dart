import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/aya_file/edit_user_screen_aya.dart';
import 'package:mindpal/main.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/add_medicine_name.dart';
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
  String? patientCode;
  String? patientId;
  Patients? patient;

  bool isLoading = true;
  List<Medicines> medicines = [];
  List<String> bottleNum = [
    'Motor1',
    'Motor2',
    'Motor3',
    'Motor4',
    'Motor5',
  ];

  String bottle1 = 'Motor1';
  String bottle2 = 'Motor2';
  String bottle3 = 'Motor3';
  String bottle4 = 'Motor4';
  String bottle5 = 'Pump';

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

  Future<void> sendPatientMedicinesToBothFirebase1(String patientId) async {
    try {
      Patients patient = await ApiManger.getPatientById1(patientId);
      print("Patient name: ${patient.name}");
      print("Medicines count: ${patient.medicines?.length ?? 0}");
      print(patientId);

      if (patient.medicines != null) {
        for (var med in patient.medicines!) {
          print("Medicine name: ${med.name}, dosage: ${med.dosage}");
        }
      }

      if (patient.medicines == null || patient.medicines!.isEmpty) return;

      Map<String, dynamic> firebaseData = {};

      for (var med in patient.medicines!) {
        String bottleName = med.numPottle ?? "MotorX";

        if (med.startDate == null || med.timeToTake == null) continue;

        DateTime startDate = DateTime.parse(med.startDate!);
        String? timeToTake = med.timeToTake!;

        String dateString =
            '${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year}';

        String timeValue = "2";

        firebaseData[bottleName] = {
          "Clock": timeToTake,
          "Date": dateString,
          "Time": timeValue,
        };
      }

      final mainDbRef = FirebaseDatabase.instance.ref();
      await mainDbRef.child('AlzFix').set(firebaseData);

      print("✅ All medicines sent to both Firebase successfully");
    } catch (e) {
      print("❌ Error sending medicines to Firebase: $e");
    }
  }

  Future<void> sendPatientMedicinesToBothFirebase(String patientId) async {
    try {
      Patients patient = await ApiManger.getPatientById1(patientId);
      print("Patient name: ${patient.name}");
      print("Medicines count: ${patient.medicines?.length ?? 0}");
      print(patientId);

      if (patient.medicines == null || patient.medicines!.isEmpty) return;

      Map<String, dynamic> firebaseData = {};

      final medicines = patient.medicines!.take(5).toList();

      for (int i = 0; i < medicines.length; i++) {
        var med = medicines[i];

        if (med.startDate == null || med.timeToTake == null) continue;

        String motorName = "Motor${i + 1}";
        if (motorName == "Motor5") {
          motorName = "Pump";
        }

        DateTime startDate = DateTime.parse(med.startDate!);
        String? timeToTake = med.timeToTake!;

        String dateString =
            '${startDate.day.toString().padLeft(2, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.year}';

        String timeValue = "2";

        firebaseData[motorName] = {
          "Date": dateString,
          "Clock": timeToTake,
          "Time": timeValue,
        };
      }

      final secondaryDbRef = FirebaseDatabase.instanceFor(
              app: secondaryApp,
              databaseURL:
                  "https://alzfix-1-default-rtdb.europe-west1.firebasedatabase.app/")
          .ref();
      await secondaryDbRef.child('AlzFix').set(firebaseData);

      final mainDbRef = FirebaseDatabase.instance.ref();
      await mainDbRef.child('AlzFix').set(firebaseData);

      print("✅ All medicines sent to Firebase for 5 motors successfully");
    } catch (e) {
      print("❌ Error sending medicines to Firebase: $e");
    }
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
        medicines = patient?.medicines ?? [];
        isLoading = false;

        print("Loaded medicines: ${patient?.medicines?.length ?? 0}");
        patient?.medicines?.forEach((med) {
          print("Medicine name: ${med.name}, Bottle: ${med.numPottle}");
        });
        for (var m in medicines) {
          print("${m.name} -> ${m.numPottle}");
        }
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
                              itemCount: bottleNum.length,
                              itemBuilder: (context, index) {
                                String bottle = bottleNum[index];
                                String dosageStr =
                                    getMedicineAmountByBottle(bottle);
                                int dosage = int.tryParse(dosageStr) ?? 0;

                                String imagePath;
                                if (dosageStr == 'empty') {
                                  imagePath = 'assets/images/U 1.png';
                                } else if (dosage >= 25) {
                                  imagePath =
                                      'assets/images/bottle_high_pills.png';
                                } else if (dosage > 0) {
                                  imagePath =
                                      'assets/images/bottle_low_pills.png';
                                } else {
                                  imagePath = 'assets/images/U 1.png';
                                }
                                return InkWell(
                                  onTap: () async {
                                    String? medName =
                                        getMedicineNameByBottle(bottle);

                                    if (medName == 'empty' || medName.isEmpty) {
                                      // لو مفيش دواء في الزجاجة، روح لصفحة إضافة اسم الدواء
                                      await Navigator.pushNamed(
                                        context,
                                        AddMedicineName.routeName,
                                        arguments: {
                                          'patientCode': patientCode,
                                          'numBottle': bottle,
                                        },
                                      );
                                    } else {
                                      // لو فيه دواء، روح لصفحة تانية مثلاً TypeMedicine
                                      await Navigator.pushNamed(
                                        context,
                                        EditUserScreen.routeName,
                                        arguments: {
                                          'patientCode': patientCode,
                                          'numBottle': bottle,
                                          'medicineName': medName,
                                          'medicine': medicines[index],
                                        },
                                      );
                                    }

                                    // تحميل البيانات بعد الرجوع
                                    if (patientId != null) {
                                      await loadPatients();
                                    }
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: width * 0.034),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF292929),
                                      border: Border.all(
                                          color: Color(0xFFA27EFC), width: 1),
                                      borderRadius: BorderRadius.circular(15),
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
                                        Center(child: Image.asset(imagePath)),
                                        SizedBox(height: 8),
                                        Text(
                                          getMedicineNameByBottle(bottle),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '(${getMedicineAmountByBottle(bottle)})pills',
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
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      sendPatientMedicinesToBothFirebase(patientId!);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.05,
                          left: width * 0.05,
                          top: width * 0.03,
                          bottom: width * 0.03),
                      child: Text(
                        "Send to Device",
                        textAlign: TextAlign.center,
                        style: AppStyle.black18700,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
