import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/add_medicine.dart';
import 'package:mindpal/yosef/add_medicine_name.dart';
import 'package:mindpal/yosef/choose_bottles.dart';
import 'package:mindpal/yosef/create_DoctorAccount.dart';
import 'package:mindpal/yosef/create_patientAccount.dart';
import 'package:mindpal/yosef/doctor_home_page.dart';
import 'package:mindpal/yosef/doctor_tab.dart';
import 'package:mindpal/yosef/done_medicine_screen.dart';
import 'package:mindpal/yosef/done_screen.dart';
import 'package:mindpal/yosef/firebase_options.dart';
import 'package:mindpal/yosef/hafez.dart';
import 'package:mindpal/yosef/home_admin_screen.dart';
import 'package:mindpal/yosef/home_tab.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:mindpal/yosef/patient_information.dart';
import 'package:mindpal/yosef/patient_tab.dart';
import 'package:mindpal/yosef/select_role.dart';
import 'package:mindpal/yosef/success_add_patient.dart';
import 'package:mindpal/yosef/success_page.dart';
import 'package:mindpal/yosef/type_medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadTokenFromSharedPrefs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission for notifications');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  runApp(MyApp());
}

Future<void> loadTokenFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ApiConstants.Token = prefs.getString('token');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateDoctorAccount.routeName: (context) => CreateDoctorAccount(),
        DoctorHomePage.routeName: (context) => DoctorHomePage(),
        PatientInformation.routeName: (context) => PatientInformation(),
        SuccessPage.routeName: (context) => SuccessPage(),
        AddMedicine.routeName: (context) => AddMedicine(),
        ChooseBottles.routeName: (context) => ChooseBottles(),
        AddMedicineName.routeName: (context) => AddMedicineName(),
        SelectRole.routeName: (context) => SelectRole(),
        CreatePatientAccount.routeName: (context) => CreatePatientAccount(),
        HomeAdminScreen.routeName: (context) => HomeAdminScreen(),
        DoneScreen.routeName: (context) => DoneScreen(),
        DoneMedicineScreen.routeName: (context) => DoneMedicineScreen(),
        HomeTab.routeName: (context) => HomeTab(),
        DoctorTab.routeName: (context) => DoctorTab(),
        PatientTab.routeName: (context) => PatientTab(),
        SuccessAddPatient.routeName: (context) => SuccessAddPatient(),
        Test.routeName: (context) => Test(),
        TypeMedicine.routeName: (context) => TypeMedicine()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
