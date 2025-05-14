import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/home_admin_screen.dart';
import 'package:mindpal/models/SignInResponse.dart';
import 'package:mindpal/services/api_manger.dart';
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

  Future<void> signIn() async {
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final signInRequest = SignInRequest(
      name: nameController.text.trim(),
      password: passwordController.text.trim(),
      role: role!.toLowerCase(),
      deviceToken: 'some_device_token',
    );

    try {
      // إرسال البيانات عبر الـ API
      SignInResponse response = await ApiManger.postSignIn(signInRequest);

      // إذا تم الرد بنجاح، انتقل إلى الشاشة المناسبة حسب الدور
      if (response.token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token!);
        switch (role) {
          case 'Doctor':
            Navigator.pushNamed(context, '/doctorHome');
            break;
          case 'Patient':
            Navigator.pushNamed(context, '/patientHome');
            break;
          case 'Admin':
            Navigator.pushNamed(context, HomeAdminScreen.routeName);
            break;
          default:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid role')),
            );
        }
      } else {
        // عرض رسالة الخطأ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Login failed')),
        );
      }
    } catch (e) {
      // في حالة حدوث خطأ في الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign in')),
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
                height: height * 0.2,
              ),
              Text(
                ' please select role',
                style: AppStyle.gray16700,
              ),
              SizedBox(
                height: height * 0.08,
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
                  items: ["Patient", "Doctor", "Admin"].map((role) {
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
              SizedBox(height: height * 0.2),
              Center(
                child: ElevatedButton(
                    onPressed: signIn,
                    child: Padding(
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
