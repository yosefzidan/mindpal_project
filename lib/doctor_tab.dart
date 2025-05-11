import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/create_DoctorAccount.dart';

class DoctorTab extends StatefulWidget {
  static const String routeName = "DoctorTab";

  @override
  DoctorTabState createState() => DoctorTabState();
}

class DoctorTabState extends State<DoctorTab> {
  List<String> doctorNames = [
    'Joo',
    'hana',
    'malak',
    'Joo',
    'hana',
    'malak',
    'Joo',
    'hana',
    'malak',
    'Joo',
    'hana',
    'malak',
    'Joo',
    'hana',
    'malak',
    'Joo',
    'hana',
    'malak',
  ];

  void _addDoctor() {
    setState(() {
      Navigator.pushNamed(context, CreateDoctorAccount.routeName);
    });
  }

  void _deleteDoctor(int index) {
    setState(() {
      doctorNames.removeAt(index);
    });
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
                height: height * 0.1,
              ),
              Center(
                child: Text(
                  'Add Another Doctor\nAccount',
                  textAlign: TextAlign.center,
                  style: AppStyle.gray24700,
                ),
              ),
              SizedBox(height: height * 0.07),
              Text(
                'Doctor Names',
                style: AppStyle.gray24700,
              ),
              SizedBox(height: height * 0.04),
              Expanded(
                child: ListView.builder(
                  itemCount: doctorNames.length,
                  itemBuilder: (context, index) {
                    final doctorName = doctorNames[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF292929),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0xFFA27AFC), width: 1),
                      ),
                      child: ListTile(
                        title: Text(
                          doctorName,
                          style: AppStyle.gray16400,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.white),
                          onPressed: () => _deleteDoctor(index),
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
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.07,
              )
            ],
          ),
        ),
      ),
    );
  }
}
