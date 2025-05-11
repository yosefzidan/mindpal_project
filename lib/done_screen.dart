import 'package:flutter/material.dart';
import 'package:mindpal/add_medicine.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/home_admin_screen.dart';

class DoneScreen extends StatelessWidget {
  static const String routeName = "DoneScreen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/done.png',
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/Group 36272.png'),
              Center(
                  child: Text(
                'You are all set !',
                style: AppStyle.white26700,
              )),
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddMedicine.routeName);
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
        ],
      ),
    );
  }
}
