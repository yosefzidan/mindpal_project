import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PillReportScreen extends StatefulWidget {
  final String patientName;

  const PillReportScreen({required this.patientName, Key? key})
      : super(key: key);

  @override
  _PillReportScreenState createState() => _PillReportScreenState();
}

class _PillReportScreenState extends State<PillReportScreen> {
  int selectedTab = 1; // 0: Day, 1: Week, 2: Month

  // Example data for week/month
  final List<List<int>> weekData = [
    [1, 0, 1], // Day 1: [Taken, Not Taken, Taken]
    [1, 1, 1],
    [0, 0, 1],
    [1, 1, 0],
    [1, 0, 0],
    [1, 1, 1],
    [0, 1, 1],
  ];

  final List<String> weekDays = const ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181829),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181829),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.patientName}'s pill reports",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "This is the report for the patient named Ahmed Ali.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tab Switcher
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton("Day", 0),
                const SizedBox(width: 8),
                _buildTabButton("Week", 1),
                const SizedBox(width: 8),
                _buildTabButton("Month", 2),
              ],
            ),
            const SizedBox(height: 16),
            // Date Selector
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
                const Icon(Icons.calendar_today, color: Colors.purpleAccent),
              ],
            ),
            const SizedBox(height: 16),
            // Stats Section
            Expanded(
              child: selectedTab == 0 ? _buildDailyView() : _buildBarChart(),
            ),
            const SizedBox(height: 16),
            const Text(
              "This is the report for the patient named Ahmed Ali.",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF181829),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: "Reports",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color:
                selectedTab == index ? Colors.purpleAccent : Colors.transparent,
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
        color: const Color(0xFF23234A),
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
        color: const Color(0xFF23234A),
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
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        fromY: 0,
                        toY: weekData[index][0].toDouble(),
                        color: Colors.green,
                        width: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        fromY: 0,
                        toY: weekData[index][1].toDouble(),
                        color: Colors.red,
                        width: 8,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        fromY: 0,
                        toY: weekData[index][2].toDouble(),
                        color: Colors.blue,
                        width: 8,
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
        color: const Color(0xFF2A2A4A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purpleAccent.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medication,
              color: Colors.purpleAccent,
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
