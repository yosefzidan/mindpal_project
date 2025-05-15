import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/yosef/home_admin_screen.dart';

class CreateDoctorAccount extends StatefulWidget {
  static const String routeName = "CreateDoctorAccount";

  @override
  State<CreateDoctorAccount> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateDoctorAccount> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  void handleAddAccount() async {
    String name = nameController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("not fond name")),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("not fond name")),
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
      Navigator.pushNamed(context, HomeAdminScreen.routeName);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
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
            Center(
                child: Text(
              'Create Your Account',
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
                  borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
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
              "   Confirm password",
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
                  borderSide: BorderSide(color: Color(0xFFA27AFC), width: 1),
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
            SizedBox(height: height * 0.09),
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
