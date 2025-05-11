import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = "HomeTab";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              textAlign: TextAlign.center,
              'Hey Admin please add\n accounts for the doctors\n and patients',
              style: AppStyle.gray24700,
            ),
          ),
          Center(
            child: Image.asset('assets/images/Group 26649.png'),
          )
        ],
      ),
    );
  }
}
