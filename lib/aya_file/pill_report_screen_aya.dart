import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindpal/aya_file/radiology_report_screen_aya.dart';
import 'package:mindpal/aya_file/screens_aya/pill_report_screen_aya.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class PillReportScreen extends StatefulWidget {
  static const String routeName = "PillReportScreen";


  @override
  State<PillReportScreen> createState() => _PillReportScreenState();
}

class _PillReportScreenState extends State<PillReportScreen>
    with SingleTickerProviderStateMixin {
  Patients? patients;
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
    String patient = patients?.name ?? "null";
    Patients ppatient = patients!;
    List<Medicines> medicines = ppatient.medicines!;
    return Scaffold(
      backgroundColor: const Color(0xFF18181B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF18181B),
        elevation: 0,
        title: Text(
          "${patient}'s pill reports",
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
          _DailyStats(
            ppatients: ppatient,
          ),
          _WeeklyStats(
            ppatients: ppatient,
          ),
          _MonthlyStats(
            ppatients: ppatient,
          ),
        ],
      ),
    );
  }
}

class _DailyStats extends StatelessWidget {
  final Patients ppatients;

  const _DailyStats({required this.ppatients, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Medicines> medicines = ppatients.medicines ?? [];

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          DateFormat('d MMM').format(DateTime.now()), // مثال: 22 Jun
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PillReportScreen2.routeName,
                        arguments: {'patient': ppatients},
                      );
                    },
                    child: _PillStatRow(
                      medicine.name ?? "Unnamed",
                      "${medicine.type}",
                      DateFormat('d/M/y').format(DateTime.parse(
                          medicine.endDate!)), // ← يطبع 22/6/2003
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
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
              Navigator.pushNamed(
                context,
                RadiologyReportScreen.routeName,
                arguments: {"patient": ppatients},
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
    return Container(
      decoration: BoxDecoration(
          border: BoxBorder.fromBorderSide(
              BorderSide(width: 2, color: Color(0xFFA27EFC))),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(time, style: const TextStyle(color: Colors.white54)),
        trailing: Text(
          status,
          style: TextStyle(
              color: Color(0xFFD0D2D1),
              fontWeight: FontWeight.bold,
              fontSize: 14),
        ),
      ),
    );
  }
}

class _WeeklyStats extends StatelessWidget {
  final Patients ppatients;

  const _WeeklyStats({required this.ppatients, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Medicines> medicines = ppatients.medicines ?? [];

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          DateFormat('d MMM').format(DateTime.now()), // مثال: 22 Jun
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PillReportScreen2.routeName,
                        arguments: {'patient': ppatients},
                      );
                    },
                    child: _PillStatRow(
                      medicine.name ?? "Unnamed",
                      "${medicine.type}",
                      DateFormat('d/M/y').format(DateTime.parse(
                          medicine.endDate!)), // ← يطبع 22/6/2003
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
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
              Navigator.pushNamed(
                context,
                RadiologyReportScreen.routeName,
                arguments: {"patient": ppatients},
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

class _MonthlyStats extends StatelessWidget {
  final Patients ppatients;

  const _MonthlyStats({required this.ppatients, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Medicines> medicines = ppatients.medicines ?? [];

    return Column(
      children: [
        const SizedBox(height: 16),
        Text(
          DateFormat('d MMM').format(DateTime.now()), // مثال: 22 Jun
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PillReportScreen2.routeName,
                        arguments: {'patient': ppatients},
                      );
                    },
                    child: _PillStatRow(
                      medicine.name ?? "Unnamed",
                      "${medicine.type}",
                      DateFormat('d/M/y').format(DateTime.parse(
                          medicine.endDate!)), // ← يطبع 22/6/2003
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
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
              Navigator.pushNamed(
                context,
                RadiologyReportScreen.routeName,
                arguments: {"patient": ppatients},
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
