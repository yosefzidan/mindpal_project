import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/models/DoctorResponse.dart';
import 'package:mindpal/models/PatientResponseM.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/choose_bottles.dart';
import 'package:mindpal/yosef/create_patientAccount.dart';

class PatientTab extends StatefulWidget {
  static const String routeName = "PatientTab";

  @override
  PatientTabState createState() => PatientTabState();
}

class PatientTabState extends State<PatientTab> {
  List<Patients> patients = [];
  bool isLoading = true;
  List<Doctor> doctors = [];

  @override
  void initState() {
    super.initState();
    loadPatients();
    loadDoctors();
  }

  Future<void> loadDoctors() async {
    try {
      final fetchedDoctors = await ApiManger.getAllDoctor();
      setState(() {
        doctors = fetchedDoctors;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching doctors: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load doctors")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadPatients() async {
    try {
      final fetchedPatients = await ApiManger.getAllPatients();
      setState(() {
        patients = fetchedPatients;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching patients: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load patients")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  void _addPatient() {
    Navigator.pushNamed(context, CreatePatientAccount.routeName)
        .then((_) => loadPatients()); // Reload after returning from create page
  }

  String getDoctorNameById(String? doctorId) {
    if (doctorId == null) return "Unknown";
    final doctor = doctors.firstWhere(
      (doc) => doc.id == doctorId,
      orElse: () => Doctor(name: "Unknown"),
    );
    return doctor.name ?? "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Center(
                child: Text(
                  'Add Another Patient\nAccount',
                  textAlign: TextAlign.center,
                  style: AppStyle.gray24700,
                ),
              ),
              SizedBox(height: height * 0.04),
              Text(
                'Patient Names',
                style: AppStyle.gray24700,
              ),
              SizedBox(height: height * 0.02),
              isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepPurple))
                  : patients.isEmpty
                      ? Center(
                          child: Text("No Patients found",
                              style: AppStyle.gray16400))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: patients.length,
                            itemBuilder: (context, index) {
                              final patient = patients[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ChooseBottles.routeName,
                                      arguments: {
                                        'patientCode': patient.code,
                                        'patientId': patient.id,
                                      });
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF292929),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Color(0xFFA27AFC), width: 1),
                                  ),
                                  child: ListTile(
                                    trailing: Text(
                                      'DR/\n${getDoctorNameById(patient.doctorId)}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 9),
                                    ),
                                    title: Text(
                                      patient.name ?? "Unknown",
                                      style: AppStyle.gray18400,
                                    ),
                                  ),
                                ),
                              );
                            },
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _addPatient,
                child: Center(
                  child: Text(
                    '+ Add Another Account To Your Table',
                    style: TextStyle(
                      color: Color(0xFFA27AFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              )
            ],
          ),
        ),
      ),
    );
  }
}
