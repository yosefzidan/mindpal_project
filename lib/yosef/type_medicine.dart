import 'package:flutter/material.dart';
import 'package:mindpal/app_style.dart';
import 'package:mindpal/aya_file/medication_form_screen_aya.dart';

class TypeMedicine extends StatefulWidget {
  static const String routeName = "TypeMedicine";

  @override
  State<TypeMedicine> createState() => _TypeMedicineState();
}

class _TypeMedicineState extends State<TypeMedicine> {
  final TextEditingController numAmountController = TextEditingController();

  final TextEditingController numPillsController = TextEditingController();
  String? patientCode;

  String? numBottle;

  String? medicineName;

  String? type;

  int selectedIndex = 0;

  final List<String> medicineImages = [
    'assets/images/caps7.png',
    'assets/images/GroupM.png',
    'assets/images/pill.png',
  ];
  List<String> typeMedicine = [
    'mashrob',
    'bershama',
    'copsola',
  ];

  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      patientCode = args['patientCode'];
      medicineName = args['medicineName'].toString();
      numBottle = args['numBottle'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Color(0xFFA27AFC)),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: height * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Center(
                child: Text(
                  ' Enter your patient’s medication details.',
                  textAlign: TextAlign.center,
                  style: AppStyle.gray24700,
                ),
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Text(
                'Select medicine type',
                style: AppStyle.gray16400,
              ),
              SizedBox(
                height: height * 0.027,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      List.generate(medicineImages.length * 2 - 1, (index) {
                    if (index.isOdd) {
                      return SizedBox(width: 12);
                    }
                    final actualIndex = index ~/ 2;
                    final isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          type = typeMedicine[selectedIndex];
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected ? Color(0xFFA27AFC) : Colors.grey,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Color(0xFFA27AFC).withOpacity(0.4),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Image.asset(
                          medicineImages[actualIndex],
                          width: width * 0.18,
                          height: width * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                'Amount(per one reception)',
                style: AppStyle.gray16400,
              ),
              SizedBox(
                height: height * 0.027,
              ),
              TextFormField(
                controller: numAmountController,
                style: TextStyle(color: Color(0xFFD0D2D1)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF292929),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      numAmountController.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.027,
              ),
              Text(
                'Number of pills intake a day',
                style: AppStyle.gray16400,
              ),
              SizedBox(
                height: height * 0.027,
              ),
              TextFormField(
                controller: numPillsController,
                style: TextStyle(color: Color(0xFFD0D2D1)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF292929),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFA27AFC), width: 2),
                  ),
                  hintText: 'Enter Number of pills',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () {
                      numPillsController.clear();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (type == null || numPillsController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "Please select a medicine type and enter number of pills")),
                        );
                        return;
                      }
                      Navigator.pushNamed(arguments: {
                        'patientCode': patientCode,
                        'medicineName': medicineName,
                        'numBottle': numBottle,
                        'type': type,
                        'numPills': numPillsController.text
                      }, context, MedicationFormScreen.routeName);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: width * 0.15,
                          left: width * 0.15,
                          top: width * 0.03,
                          bottom: width * 0.03),
                      child: Text('Next', style: AppStyle.black18700),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
