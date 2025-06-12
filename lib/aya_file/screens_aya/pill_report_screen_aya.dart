import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class PillReportScreen2 extends StatefulWidget {
  static const String routeName = "PillReportScreen_aya";


  @override
  _PillReportScreen2State createState() => _PillReportScreen2State();
}

class _PillReportScreen2State extends State<PillReportScreen2> {
  int selectedTab = 1; // 0: Day, 1: Week, 2: Month
  Patients? patients;

  final List<List<int>> weekData = [
    [1, 0, 1],
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 0],
    [1, 0, 0],
    [1, 1, 1],
    [0, 1, 1],
  ];

  final List<String> weekDays = const ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      patients = args['patient'];
    }
  }

  @override
  Widget build(BuildContext context) {
    String patientName = patients?.name ?? 'null';

    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${patientName}'s pill reports",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tab Switcher
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(
                    width: 1,
                    color: Color(0xFFA27EFC),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton("Day", 0),
                  const SizedBox(width: 8),
                  _buildTabButton("Week", 1),
                  const SizedBox(width: 8),
                  _buildTabButton("Month", 2),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedTab == 1
                      ? "10 SEP - 17 SEP"
                      : "First week of SEP 2023",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFA27EFC),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: selectedTab == 0 ? _buildDailyView() : _buildBarChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color:
                selectedTab == index ? Color(0xFFA27EFC) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selectedTab == index ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF191919),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Medication",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: const [
                _MedicationItem(
                  name: "Oxytocin",
                  time: "10:00 AM",
                  status: "Taken",
                  dosage: "10mg",
                ),
                _MedicationItem(
                  name: "Naloxone",
                  time: "04:00 PM",
                  status: "Skipped",
                  dosage: "5mg",
                ),
                _MedicationItem(
                  name: "Vitamin D",
                  time: "08:00 PM",
                  status: "Pending",
                  dosage: "1000IU",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Medication Adherence",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 3,
                barGroups: List.generate(weekData.length, (index) {
                  final taken = weekData[index][0].toDouble();
                  final skipped = weekData[index][1].toDouble();
                  final pending = weekData[index][2].toDouble();

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: taken + skipped + pending,
                        width: 14,
                        rodStackItems: [
                          BarChartRodStackItem(
                              0, taken, const Color(0xFFFFFF93)),
                          BarChartRodStackItem(
                              taken, taken + skipped, const Color(0xFFFFADA9)),
                          BarChartRodStackItem(
                              taken + skipped,
                              taken + skipped + pending,
                              const Color(0xFFBBA0FF)),
                        ],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value < 0 || value >= weekDays.length)
                          return const SizedBox();
                        return Text(
                          weekDays[value.toInt()],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MedicationItem extends StatelessWidget {
  final String name;
  final String time;
  final String status;
  final String dosage;

  const _MedicationItem({
    required this.name,
    required this.time,
    required this.status,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'taken':
        statusColor = Colors.green;
        break;
      case 'skipped':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0x12bc0ee3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medication,
              color: Color(0xFFA27EFC),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dosage,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}