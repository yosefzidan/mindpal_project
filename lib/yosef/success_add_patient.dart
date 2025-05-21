import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/yosef/patient_information.dart';

class SuccessAddPatient extends StatefulWidget {
  static const String routeName = "SuccessAddPatient";

  @override
  State<SuccessAddPatient> createState() => _SuccessAddPatientState();
}

class _SuccessAddPatientState extends State<SuccessAddPatient> {
  String? name;

  String? password;

  String? doctorCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      name = args['name'];
      password = args['password'];
      doctorCode = args['doctorCode'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                    child: Image.asset(
                  "assets/images/Untitled-1 copy.png",
                )),
              ),
              Center(
                  child: Text(
                textAlign: TextAlign.center,
                'an account had been \n created for the patient',
                style: AppStyle.gray24700,
              )),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                    textAlign: TextAlign.center,
                    style: AppStyle.grayF16500,
                    'now we need to Enter patient’s\n medication details.'),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Center(
                child: Image.asset("assets/images/Group 26649.png"),
              ),
              SizedBox(
                height: height * 0.13,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PatientInformation.routeName,
                        arguments: {
                          'name': name,
                          'password': password,
                          'doctorCode': doctorCode,
                        },
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.15,
                          left: width * 0.15,
                          top: width * 0.03,
                          bottom: width * 0.03),
                      child: Text(
                        'Next',
                        style: AppStyle.black18700,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
