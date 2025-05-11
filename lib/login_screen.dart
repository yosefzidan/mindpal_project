import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/home_admin_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "loginScreen";

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
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, HomeAdminScreen.routeName);
                    },
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
