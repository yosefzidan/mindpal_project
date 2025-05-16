import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selected; // 0: Home, 1: Reports
  const BottomNavBar({required this.selected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF18181B),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.medication_outlined,
                  color: selected == 0 ? Color(0xFFA892F5) : Colors.white54),
              SizedBox(height: 4),
              Text('pills',
                  style: TextStyle(
                      color:
                          selected == 0 ? Color(0xFFA892F5) : Colors.white54)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.insert_chart_outlined,
                  color: selected == 1 ? Color(0xFFA892F5) : Colors.white54),
              SizedBox(height: 4),
              Text('Reports',
                  style: TextStyle(
                      color:
                          selected == 1 ? Color(0xFFA892F5) : Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }
}
