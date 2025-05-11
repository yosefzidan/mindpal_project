import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/done_screen.dart';

class PatientInformation extends StatefulWidget {
  static const String routeName = "PatientInformation";

  @override
  State<PatientInformation> createState() => _PatientInformationState();
}

class _PatientInformationState extends State<PatientInformation> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    String? selectedGender;
    String? selectedStage;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text('Hey Admin ', style: AppStyle.gray24700),),
              Center(child: Text(
                'Let’s start from the basics.', style: AppStyle.gray24400,),),
              SizedBox(height: 8,),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'we’ll use this information to best personalise your patient health recommendation. We will never share it.'
                  , style: AppStyle.grayG18400,
                ),
              ),
              SizedBox(height: height * 0.05,),
              Text("  Patient’s gender*", style: AppStyle.gray16400),
              SizedBox(height: height * 0.02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.black,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(

                  dropdownColor: Color(0xFF825DDE),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: selectedGender,
                  hint: Text("Choose your gender", style: AppStyle.grayB16400),
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFFA27AFC)),
                  items: ["Male", "Female",].map((gender) {
                    return DropdownMenuItem(
                      value: gender,
                      child: Text(gender,
                          style: TextStyle(color: Colors.white)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                ),
              ),
              SizedBox(height: height * 0.05),
              Text("  Patient's age?*", style: AppStyle.gray16400),
              SizedBox(height: height * 0.02),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Color(0xFFA27AFC), width: 1),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFA27AFC), width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Color(0xFFA27AFC), width: 1),
                    ),
                    hintText: 'Enter Age',
                    hintStyle: AppStyle.grayB16400


                ),
              ),
              SizedBox(height: height * 0.02,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, DoneScreen.routeName);
                    }
                    , child: Padding(

                  padding: EdgeInsets.only(right: width * 0.15,
                      left: width * 0.15,
                      top: width * 0.03,
                      bottom: width * 0.03),
                  child: Text('Next', style: AppStyle.black18700,),
                )),
              ),
              SizedBox(height: height * 0.04,)


            ],
          ),
        ),
      ),
    );
  }
}
