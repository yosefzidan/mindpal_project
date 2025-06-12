import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/edit_bottle_screen_aya.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:table_calendar/table_calendar.dart';

class BottlesScreen extends StatefulWidget {
  static const String routeName = "BottlesScreen";

  final Patients patients;

  const BottlesScreen({Key? key, required this.patients}) : super(key: key);

  @override
  State<BottlesScreen> createState() => _BottlesScreenState();
}

class _BottlesScreenState extends State<BottlesScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<int> years = List.generate(16, (index) => 2015 + index);

  final List<Map<String, String>> bottles = [
    {
      'label': 'First Pill Bottle',
      'name': 'Memantine',
      'count': '20',
      'desc': '(20)pills',
      'img': 'assets/bottle1.png',
    },
    {
      'label': 'Second Pill Bottle',
      'name': 'Donepezil',
      'count': '10',
      'desc': '(10)pills remain',
      'img': 'assets/bottle2.png',
    },
    {
      'label': 'Third Pill Bottle',
      'name': 'Empty',
      'count': '0',
      'desc': '(0)pills',
      'img': 'assets/bottle3.png',
    },
  ];


  void _editBottle(Map<String, String> bottle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditBottleScreen(
          bottle: bottle,
          onSave: (updatedBottle) {
            setState(() {
              final index = bottles.indexOf(bottle);
              if (index != -1) {
                bottles[index] = updatedBottle;
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String patientName = widget.patients.name ?? 'null';
    final purple = const Color(0xFFA27AFC);
    final dark = const Color(0xFF191919);

    return Scaffold(
      backgroundColor: dark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
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
            ),
            // Bills Bottles Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Bills Bottles',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '${bottles.length} Bottles',
                    style: TextStyle(
                      color: purple,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            // Bottles List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                itemCount: bottles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final bottle = bottles[index];
                  return _buildBottleCard(bottle);
                },
              ),
            ),
            // Treatment schedule message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Inter',
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'This is the treatment schedule for the\npatient named ',
                    ),
                    TextSpan(
                      text: patientName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
    );
  }

  Widget _buildBottleCard(Map<String, String> bottle) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23232B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _editBottle(bottle),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA892F5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medication_outlined,
                    color: Color(0xFFA892F5),
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bottle['name'] ?? 'Unknown',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Count: ${bottle['count'] ?? '0'}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Inter',
                        ),
                      ),
                      if (bottle['desc']?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 4),
                        Text(
                          bottle['desc'] ?? '',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFA892F5),
                  ),
                  onPressed: () => _editBottle(bottle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
