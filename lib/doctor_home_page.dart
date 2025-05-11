import 'package:flutter/material.dart';

class DoctorHomePage extends StatelessWidget {
  static const String routeName = "DoctorHomePage";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.09,
            ),
            Center(
                child: Image.asset(
              "assets/images/Untitled-1 copy.png",
            )),
            SizedBox(
              height: height * 0.03,
            ),
            Center(
                child: Text(
              'Create Account for your patient',
              style: TextStyle(color: Color(0xFFD0D2D1)),
            )),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "  Name",
              style: TextStyle(color: Color(0xFFD0D2D1)),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
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
              ),
            ),
            SizedBox(
              height: height * 0.028,
            ),
            Text(
              "  password",
              style: TextStyle(color: Color(0xFFD0D2D1)),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
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
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(
              height: height * 0.028,
            ),
            Text(
              "   Confirm password",
              style: TextStyle(color: Color(0xFFD0D2D1)),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
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
                hintText: 'Enter your Confirm password',
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: width * 0.15,
                              left: width * 0.15,
                              top: width * 0.03,
                              bottom: width * 0.03),
                          child: Text('Next'),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
