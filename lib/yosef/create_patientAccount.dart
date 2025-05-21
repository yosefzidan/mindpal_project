import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/models/DoctorResponse.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/success_add_patient.dart';

class CreatePatientAccount extends StatefulWidget {
  static const String routeName = "CreatePatientAccount";

  @override
  State<CreatePatientAccount> createState() => _CreatePatientAccountState();
}

class _CreatePatientAccountState extends State<CreatePatientAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  void handleAddAccount() async {
    String name = nameController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    String doctorName = doctorNameController.text.trim();

    if (name.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        doctorName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    try {
      List<Doctor> allDoctors = await ApiManger.getAllDoctor();

      Doctor? matchedDoctor = allDoctors.firstWhere(
        (doc) => (doc.name ?? '').toLowerCase() == doctorName.toLowerCase(),
        orElse: () => Doctor(),
      );

      if (matchedDoctor.code == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Doctor not found")),
        );
        return;
      }
      Navigator.pushNamed(
        context,
        SuccessAddPatient.routeName,
        arguments: {
          'name': name,
          'password': password,
          'doctorCode': matchedDoctor.code,
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching doctors: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
                child: Image.asset(
              "assets/images/Untitled-1 copy.png",
            )),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              'Hey Admin please create \n an account for patient',
              style: AppStyle.gray24700,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Center(
                child: Text(
              'Create Patient Account',
              style: AppStyle.gray20500,
            )),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "  Name",
              style: AppStyle.gray16700,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: nameController,
              style: TextStyle(fontSize: 17, color: Color(0xFFA6A6A6)),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
                  ),
                  hintText: 'Enter your Name',
                  hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 17)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "  password",
              style: AppStyle.gray16700,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: _isObscure2,
              style: TextStyle(fontSize: 17, color: Color(0xFFA6A6A6)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                ),
                hintText: 'Enter your Password',
                hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 17),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure2 = !_isObscure2;
                    });
                  },
                  child: Icon(
                    _isObscure2 ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.028,
            ),
            Text(
              "  Confirm password",
              style: AppStyle.gray16700,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: _isObscure,
              style: TextStyle(fontSize: 17, color: Color(0xFFA6A6A6)),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                ),
                hintText: 'Enter your Password',
                hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 17),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              "  doctor’s Name",
              style: AppStyle.gray16700,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: doctorNameController,
              style: TextStyle(fontSize: 17, color: Color(0xFFA6A6A6)),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
                  ),
                  hintText: 'Enter your Name',
                  hintStyle: TextStyle(color: Color(0xFF666666), fontSize: 17)),
            ),
            SizedBox(height: height * 0.06),
            Center(
              child: ElevatedButton(
                  onPressed: handleAddAccount,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.15,
                        left: width * 0.15,
                        top: width * 0.03,
                        bottom: width * 0.03),
                    child: Text(
                      'add account',
                      style: AppStyle.black18700,
                    ),
                  )),
            ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
