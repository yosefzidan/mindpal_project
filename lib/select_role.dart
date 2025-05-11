import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/login_screen.dart';

class SelectRole extends StatefulWidget {
  static const String routeName = "SelectRole";

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  bool _isObscure = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String? Role;

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
              height: height * 0.02,
            ),
            Center(
                child: Text(
              ' please select role',
              style: AppStyle.gray20500,
            )),
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
                value: Role,
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
                    Role = value;
                  });
                },
              ),
            ),
            SizedBox(height: height * 0.2),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
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
    );
  }
}
