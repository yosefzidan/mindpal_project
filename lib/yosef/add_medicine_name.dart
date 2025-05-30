import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/yosef/type_medicine.dart';

class AddMedicineName extends StatefulWidget {
  static const String routeName = "AddMedicineName";

  @override
  _AddMedicineNameState createState() => _AddMedicineNameState();
}

class _AddMedicineNameState extends State<AddMedicineName> {
  TextEditingController medicineName = TextEditingController();
  String? patientCode;

  String? numBottle;

  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      numBottle = args['num bottle'];
      patientCode = args['code'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.07),
          child: Column(
            children: [
              Text(
                'Hey Admin this is your first\n bottle ! ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              Text(
                'Enter your patient’s medication\n details.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF919191), fontSize: 24),
              ),
              SizedBox(height: height * 0.084),
              TextFormField(
                controller: medicineName,
                style: TextStyle(color: Color(0xFFD0D2D1)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF292929),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  hintText: 'Enter medicine name',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      medicineName.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.25,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(arguments: {
                        'patientCode': patientCode,
                        'medicineName': medicineName,
                        'numBottle': numBottle
                      }, context, TypeMedicine.routeName);
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
