import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/main.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/done_medicine_screen.dart';

class MedicationFormScreen extends StatefulWidget {
  static const String routeName = "MedicationFormScreen";

  const MedicationFormScreen({super.key});

  @override
  State<MedicationFormScreen> createState() => _MedicationFormScreenState();
}

class _MedicationFormScreenState extends State<MedicationFormScreen> {
  TimeOfDay? selectedTime;
  String? selectedHourGap;
  String? selectedInterval;
  DateTime? startDate;
  DateTime? endDate;
  String? patientCode;

  String? numBottle;

  String? medicineName;

  String? type;
  String? numPills;
  String? numAmount;
  bool isLoading = false;
  final dbRef = FirebaseDatabase.instance.ref();

  final List<String> hourGaps = [
    'Every 2 hours',
    'Every 4 hours',
    'Every 6 hours',
    'Every 8 hours',
    'Every 12 hours',
    'Every 24 hours',
  ];

  final List<String> intervals = [
    'Every 3 days',
    'Every 5 days',
    'Every 7 days',
  ];

  String formatTimeOfDayTo24(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.Hm().format(dateTime); // "HH:mm"
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFA892F5),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Color(0xFF292929)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _pickDate({required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStart ? (startDate ?? DateTime.now()) : (endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFFA892F5),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Color(0xFF292929)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Widget _buildDropdown<T>({
    required String hint,
    required T? value,
    required List<T> items,
    required void Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      dropdownColor: Color(0xFF2C2C34),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFF292929),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF9E9E9E), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF9E9E9E), width: 1),
        ),
      ),
      hint: Text(hint, style: TextStyle(color: Colors.white70)),
      icon: Icon(Icons.keyboard_arrow_down, color: Color(0xFFA892F5)),
      style: TextStyle(color: Colors.white, fontSize: 16),
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                e.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Future<void> handleSendMedicineData() async {
    print('patientCode = $patientCode');

    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    if (selectedTime == null ||
        selectedHourGap == null ||
        selectedInterval == null ||
        startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all the required fields")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final newMedicine = Medicines(
        name: medicineName,
        dosage: numAmount,
        schedule: selectedHourGap,
        type: type,
        startDate: startDate.toString(),
        endDate: endDate.toString(),
        code: patientCode,
        numPottle: numBottle,
        pillsPerDay: numPills,

        timeToTake: formatTimeOfDayTo24(selectedTime!), // صيغة 24 ساعة
      );

      await ApiManger.postMedicine(newMedicine);

      setState(() {
        isLoading = false;
      });

      Navigator.pushNamed(context, DoneMedicineScreen.routeName);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
      );
    }
  }

  Future<void> sendOrder() async {
    if (numBottle == null ||
        startDate == null ||
        selectedTime == null ||
        numPills == null) return;

    String dateString =
        '${startDate!.day.toString().padLeft(2, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.year}';
    String timeString = selectedTime!.format(context);

    final secondaryDbRef = FirebaseDatabase.instanceFor(
      app: secondaryApp,
      databaseURL: "https://OTHER_PROJECT.firebaseio.com",
    ).ref();

    await secondaryDbRef.child('AlzFix').child(numBottle!).set({
      "Date": dateString,
      "Clock": timeString,
      "Time": numPills,
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      numBottle = args['numBottle'];
      patientCode = args['patientCode'];
      medicineName = args['medicineName'];
      type = args['type'];
      numPills = args['numPills'];
      numAmount = args['numAmount'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your patient\'s medication details.'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Time to take a pill', style: AppStyle.gray16700),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(
                        color: Color(0xFF9E9E9E),
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : 'Select time',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(Icons.access_time, color: Color(0xFFA27AFC)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'How many hours apart is it taken in a day?',
                  style: AppStyle.gray16700),
              const SizedBox(height: 8),
              _buildDropdown<String>(
                hint: 'Select hours apart',
                value: selectedHourGap,
                items: hourGaps,
                onChanged: (val) => setState(() => selectedHourGap = val),
              ),
              const SizedBox(height: 24),
              Text(
                'Pill taking interval', style: AppStyle.gray16700),
              const SizedBox(height: 8),
              _buildDropdown<String>(
                hint: 'Select days',
                value: selectedInterval,
                items: intervals,
                onChanged: (val) => setState(() => selectedInterval = val),
              ),
              const SizedBox(height: 24),
              Text(
                'Start of course', style: AppStyle.gray16700),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickDate(isStart: true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(
                        color: Color(0xFF9E9E9E),
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        startDate != null
                            ? '${startDate!.day.toString().padLeft(2, '0')}.${startDate!.month.toString().padLeft(2, '0')}.${startDate!.year}'
                            : 'Select date',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(Icons.calendar_today, color: Color(0xFFA27AFC)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'End of course', style: AppStyle.gray16700),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _pickDate(isStart: false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF292929),
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(
                        color: Color(0xFF9E9E9E),
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        endDate != null
                            ? '${endDate!.day.toString().padLeft(2, '0')}.${endDate!.month.toString().padLeft(2, '0')}.${endDate!.year}'
                            : 'Select date',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Icon(Icons.calendar_today, color: Color(0xFFA27AFC)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          await handleSendMedicineData();
                        },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.15,
                              left: width * 0.15,
                              top: width * 0.03,
                              bottom: width * 0.03),
                          child: Text(
                              (selectedTime != null &&
                            selectedHourGap != null &&
                            selectedInterval != null &&
                            startDate != null &&
                            endDate != null)
                        ? 'Confirm'
                        : 'Next',
                              style: AppStyle.black18700),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
