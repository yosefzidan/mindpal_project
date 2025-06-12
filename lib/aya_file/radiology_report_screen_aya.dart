import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/widgets_aya/bottom_nav_bar_aya.dart';
import 'package:mindpal/models/PatientResponseM.dart';

class RadiologyReportScreen extends StatefulWidget {
  static const String routeName = "RadiologyReportScreen111";

  @override
  State<RadiologyReportScreen> createState() => _RadiologyReportScreenState();
}

class _RadiologyReportScreenState extends State<RadiologyReportScreen> {
  Patients? patients;

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
    return Scaffold(
      backgroundColor: Color(0xFF18181B),
      bottomNavigationBar: BottomNavBar(selected: 1),
      appBar: AppBar(
        backgroundColor: Color(0xFF18181B),
        elevation: 0,
        title: Text("${patients?.name ?? 'null'} radiology reports",
            style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
                "This is the report for the patient named ${patients?.name ?? 'null'}.",
                style: TextStyle(color: Colors.white)),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                    child: Container(height: 120, color: Colors.grey[800])),
                // Replace with Image.asset
                SizedBox(width: 8),
                Expanded(
                    child: Container(height: 120, color: Colors.grey[700])),
                // Replace with Image.asset
              ],
            ),
            SizedBox(height: 24),
            Text("Scan Analysis Results",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(
                "Diagnostic: Possible Signs Of Alzheimer's Disease Detected\nConfidence Level: AI Confidence: 87%",
                style: TextStyle(color: Colors.white70)),
            SizedBox(height: 16),
            Text("Findings",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(
              "• Abnormal Brain Activity Detected In The Hippocampus And Frontal Regions\n"
              "• Indications Of Neuronal, Atrophy And Plaque Buildup\n"
              "• Further Neurological Assessment Recommended.",
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            Text("Alzheimer's Stage",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(
                "Middle Stage: Noticeable Cognitive Decline, Confusion, Difficulty Performing Familiar Task",
                style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
