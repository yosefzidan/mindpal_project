import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/aya_file/doctor_home_screen_aya.dart';
import 'package:mindpal/models/SignInResponse.dart';
import 'package:mindpal/services/api_manger.dart';
import 'package:mindpal/yosef/home_admin_screen.dart';
import 'package:mindpal/yosef/home_patient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? role;
  bool isLoading = false;

  Future<String?> getFcmToken() async {
    await FirebaseMessaging.instance.requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print("📱 FCM Token: $token");
    return token;
  }

  Future<void> signIn() async {
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    String? deviceToken = await getFcmToken();

    final signInRequest = SignInRequest(
      name: nameController.text.trim(),
      password: passwordController.text.trim(),
      role: role!.toLowerCase(),
      deviceToken: deviceToken ?? '',
    );

    try {
      SignInResponse response = await ApiManger.postSignIn(signInRequest);

      if (response.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token!);
        switch (role) {
          case 'doctor':
            Navigator.pushNamed(context, DoctorHomeScreen.routeName);
            break;
          case 'patient':
            Navigator.pushNamed(context, HomePatient.routeName);
            break;
          case 'admin':
            Navigator.pushNamed(context, HomeAdminScreen.routeName);
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid role')),
            );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Login failed')),
        );
      }
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in: $e')),
      );
    }
  }

  void sign() {
    switch (role) {
      case 'doctor':
        Navigator.pushNamed(context, DoctorHomeScreen.routeName);
        break;
      case 'patient':
        Navigator.pushNamed(context, HomePatient.routeName);
        break;
      case 'admin':
        Navigator.pushNamed(context, HomeAdminScreen.routeName);
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid role')),
        );
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
                'Log In to Your Account ',
                style: AppStyle.gray22600,
              )),
              SizedBox(
                height: 30,
              ),
              Text("  your name or id", style: AppStyle.gray16700),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: nameController,
                style: AppStyle.grayG18400,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFD0D2D1), width: 1),
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
                  hintText: 'E-mail',
                ),
              ),
              SizedBox(
                height: height * 0.03,
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
                style: AppStyle.grayG18400,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xFFD0D2D1), width: 1)),
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
                  hintText: 'password',
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                ' please select role',
                style: AppStyle.gray16700,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFFEEEEEE), width: 1),
                  color: Colors.black,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  dropdownColor: Color(0xFF825DDE),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: role,
                  hint: Text(
                    "Choose your role",
                    style: AppStyle.gray22600,
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFFA27AFC)),
                  items: ["patient", "doctor", "admin"].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role, style: AppStyle.gray16700),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      role = value;
                    });
                  },
                ),
              ),
              SizedBox(height: height * 0.05),
              Center(
                child: ElevatedButton(
                    onPressed: signIn,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Color(0xFF292929)))
                        : Padding(
                            padding: EdgeInsets.only(
                          right: width * 0.15,
                          left: width * 0.15,
                          top: width * 0.03,
                          bottom: width * 0.03),
                      child: Text(
                        'login',
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
