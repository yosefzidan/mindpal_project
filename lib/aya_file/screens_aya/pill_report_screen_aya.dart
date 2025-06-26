import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class PillReportScreen2 extends StatefulWidget {
  static const String routeName = "PillReportScreen_aya";

  @override
  _PillReportScreen2State createState() => _PillReportScreen2State();
}

class _PillReportScreen2State extends State<PillReportScreen2> {
  int selectedTab = 0; // 0: Day, 1: Week, 2: Month
  DateTime selectedDate = DateTime.now();
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

  String _getFormattedDate(int tab, DateTime date) {
    if (tab == 0) {
      return DateFormat('d MMM').format(date);
    } else if (tab == 1) {
      final startOfWeek = date.subtract(Duration(days: date.weekday % 7));
      final endOfWeek = startOfWeek.add(const Duration(days: 6));
      final from = DateFormat('d MMM').format(startOfWeek);
      final to = DateFormat('d MMM').format(endOfWeek);
      return "$from - $to";
    } else {
      return DateFormat('MMMM y').format(date);
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$patientName's pill reports",
                style: AppStyle.gray24700,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'This is the report for the patient named\n$patientName',
                style: AppStyle.gray16700,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTabSwitcher(),
              const SizedBox(height: 16),
              _buildDateNavigationRow(),
              const SizedBox(height: 16),
              if (selectedTab == 0)
                _buildDailyView()
              else
                Column(
                  children: [
                    SizedBox(height: 300, child: _buildBarChart()),
                    const SizedBox(height: 16),
                    _buildLegend(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: const Color(0xFFA27EFC)),
      ),
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
    );
  }

  Widget _buildTabButton(String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: selectedTab == index
                ? const Color(0xFFA27EFC)
                : Colors.transparent,
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

  Widget _buildDateNavigationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left, color: Color(0xFFA27EFC)),
          onPressed: () {
            setState(() {
              if (selectedTab == 0) {
                selectedDate = selectedDate.subtract(const Duration(days: 1));
              } else if (selectedTab == 1) {
                selectedDate = selectedDate.subtract(const Duration(days: 7));
              } else {
                selectedDate =
                    DateTime(selectedDate.year, selectedDate.month - 1);
              }
            });
          },
        ),
        const SizedBox(width: 8),
        Text(
          _getFormattedDate(selectedTab, selectedDate),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.arrow_right, color: Color(0xFFA27EFC)),
          onPressed: () {
            setState(() {
              if (selectedTab == 0) {
                selectedDate = selectedDate.add(const Duration(days: 1));
              } else if (selectedTab == 1) {
                selectedDate = selectedDate.add(const Duration(days: 7));
              } else {
                selectedDate =
                    DateTime(selectedDate.year, selectedDate.month + 1);
              }
            });
          },
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () => setState(() => selectedDate = DateTime.now()),
          child: const Text(
            "Today",
            style: TextStyle(
                color: Color(0xFFA27EFC), fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildDailyView() {
    final medicines = patients?.medicines ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Daily Stats",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        ...medicines.map((medicine) => _MedicationItem(
              name: medicine.name ?? 'Unnamed',
              time: "10:00 AM",
              status: "Taken",
              dosage: "10mg",
            )),
      ],
    );
  }

  Widget _buildBarChart() {
    return BarChart(
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
                  BarChartRodStackItem(0, taken, const Color(0xFFFFFF93)),
                  BarChartRodStackItem(
                      taken, taken + skipped, const Color(0xFFFFADA9)),
                  BarChartRodStackItem(taken + skipped,
                      taken + skipped + pending, const Color(0xFFBBA0FF)),
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
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    int totalTaken = 0, totalSkipped = 0, totalPending = 0;
    for (var data in weekData) {
      totalTaken += data[0];
      totalSkipped += data[1];
      totalPending += data[2];
    }
    int total = totalTaken + totalSkipped + totalPending;
    String getPercentage(int value) {
      if (total == 0) return "0%";
      double percent = (value / total) * 100;
      return "${percent.toStringAsFixed(1)}%";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem(
            "Taken", const Color(0xFFFFFF93), getPercentage(totalTaken)),
        _buildLegendItem(
            "Skipped", const Color(0xFFFFADA9), getPercentage(totalSkipped)),
        _buildLegendItem(
            "Pending", const Color(0xFFBBA0FF), getPercentage(totalPending)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, String percentage) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          "$label ($percentage)",
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ],
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
        statusColor = const Color(0xFF6FCF97);
        break;
      case 'skipped':
        statusColor = const Color(0xFFE57373);
        break;
      default:
        statusColor = const Color(0xFFFFC107);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF292929),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xD2A27EFC), width: 1),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.asset('assets/images/Group 2.png', fit: BoxFit.fill),
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
                      fontSize: 14),
                ),
                Text(time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
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
                    fontSize: 13),
              ),
              Text(dosage,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
        ],
      ),
    );
  }
}