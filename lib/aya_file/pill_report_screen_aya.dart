import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/radiology_report_screen_aya.dart';
import 'package:mindpal/aya_file/widgets_aya/bottom_nav_bar_aya.dart';

class PillReportScreen extends StatefulWidget {
  final String patientName;

  const PillReportScreen({required this.patientName, Key? key})
      : super(key: key);

  @override
  State<PillReportScreen> createState() => _PillReportScreenState();
}

class _PillReportScreenState extends State<PillReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18181B),
      bottomNavigationBar: const BottomNavBar(selected: 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF18181B),
        elevation: 0,
        title: Text(
          "${widget.patientName}'s pill reports",
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFA892F5),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'Day'),
            Tab(text: 'Week'),
            Tab(text: 'Month'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DailyStats(patientName: widget.patientName),
          _WeeklyStats(patientName: widget.patientName),
          _MonthlyStats(patientName: widget.patientName),
        ],
      ),
    );
  }
}

class _DailyStats extends StatelessWidget {
  final String patientName;

  const _DailyStats({required this.patientName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('10 SEP', style: TextStyle(color: Colors.white70)),
        ...[
          _PillStatRow('Oxytocin', '10:00 AM', 'Taken'),
          _PillStatRow('Naloxone', '04:00 PM', 'Skipped'),
        ],
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA892F5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      RadiologyReportScreen(patientName: patientName),
                ),
              );
            },
            child: const Text(
              "Patient's Radiology Reports",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class _PillStatRow extends StatelessWidget {
  final String name, time, status;

  const _PillStatRow(this.name, this.time, this.status, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: const TextStyle(color: Colors.white)),
      subtitle: Text(time, style: const TextStyle(color: Colors.white54)),
      trailing: Text(
        status,
        style: TextStyle(
          color: status == 'Taken' ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _WeeklyStats extends StatelessWidget {
  final String patientName;

  const _WeeklyStats({required this.patientName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Weekly stats for $patientName",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class _MonthlyStats extends StatelessWidget {
  final String patientName;

  const _MonthlyStats({required this.patientName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Monthly stats for $patientName",
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
