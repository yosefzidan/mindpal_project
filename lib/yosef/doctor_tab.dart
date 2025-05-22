import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/models/DoctorResponse.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/create_doctor_account.dart';

class DoctorTab extends StatefulWidget {
  static const String routeName = "DoctorTab";

  @override
  DoctorTabState createState() => DoctorTabState();
}

class DoctorTabState extends State<DoctorTab> {
  List<Doctor> doctors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
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

  void _addDoctor() {
    Navigator.pushNamed(context, CreateDoctorAccount.routeName)
        .then((_) => loadDoctors()); // Reload after returning from create page
  }

  void _deleteDoctor(String id, int index) async {
    try {
      await ApiManger.deleteDoctor(id);
      setState(() {
        doctors.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Doctor deleted successfully")),
      );
    } catch (e) {
      print("Error deleting doctor: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete doctor")),
      );
    }
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
              SizedBox(height: height * 0.05),
              Center(
                child: Text(
                  'Add Another Doctor\nAccount',
                  textAlign: TextAlign.center,
                  style: AppStyle.gray24700,
                ),
              ),
              SizedBox(height: height * 0.04),
              Text('Doctor Names', style: AppStyle.gray24700),
              SizedBox(height: height * 0.02),
              isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF292929)))
                  : doctors.isEmpty
                      ? Center(
                          child: Text("No doctors found",
                              style: AppStyle.gray16400))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF292929),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFFA27AFC), width: 1),
                      ),
                      child: ListTile(
                        title: Text(
                                    doctor.name ?? "Unknown",
                                    style: AppStyle.gray16400,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                                    onPressed: () =>
                                        _deleteDoctor(doctor.id ?? '', index),
                                  ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _addDoctor,
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
              SizedBox(height: height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}
