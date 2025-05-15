import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';

class DoneMedicineScreen extends StatelessWidget {
  static const String routeName = "DoneMedicineScreen";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/done.png'),
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
                height: 8,
              ),
              Center(
                  child: Text(
                'The medication has been added\n to the first bottle. ',
                textAlign: TextAlign.center,
                style: AppStyle.white20600,
              )),
              SizedBox(
                height: height * 0.15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            'back to home page',
                            style: AppStyle.white20600,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: width * 0.05,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
