import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/doctor_home_screen_aya.dart';
import 'package:mindpal/aya_file/edit_user_screen_aya.dart';
import 'package:mindpal/aya_file/home_page_aya.dart';
import 'package:mindpal/aya_file/medication_form_screen_aya.dart';
import 'package:mindpal/aya_file/pill_report_screen_aya.dart';
import 'package:mindpal/aya_file/radiology_report_screen_aya.dart';
import 'package:mindpal/aya_file/screens_aya/pill_report_screen_aya.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/add_medicine.dart';
import 'package:mindpal/yosef/add_medicine_name.dart';
import 'package:mindpal/yosef/choose_bottles.dart';
import 'package:mindpal/yosef/create_doctor_account.dart';
import 'package:mindpal/yosef/create_patientAccount.dart';
import 'package:mindpal/yosef/doctor_home_page.dart';
import 'package:mindpal/yosef/doctor_tab.dart';
import 'package:mindpal/yosef/done_medicine_screen.dart';
import 'package:mindpal/yosef/done_screen.dart';
import 'package:mindpal/yosef/firebase_options.dart';
import 'package:mindpal/yosef/hafez.dart';
import 'package:mindpal/yosef/home_admin_screen.dart';
import 'package:mindpal/yosef/home_doctor_screen.dart';
import 'package:mindpal/yosef/home_patient.dart';
import 'package:mindpal/yosef/home_tab.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:mindpal/yosef/patient_information.dart';
import 'package:mindpal/yosef/patient_tab.dart';
import 'package:mindpal/yosef/select_role.dart';
import 'package:mindpal/yosef/success_add_patient.dart';
import 'package:mindpal/yosef/success_page.dart';
import 'package:mindpal/yosef/type_medicine.dart';
import 'package:shared_preferences/shared_preferences.dart';

late FirebaseApp secondaryApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadTokenFromSharedPrefs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  secondaryApp = await Firebase.initializeApp(
    name: 'secondaryApp',
    options: FirebaseOptions(
      apiKey: "AIzaSyAytd5KQK78uKb5mYxGxi-RYqYScCwCFpc",
      appId: "1:267273489508:android:226a661a5d9f9f366d2371",
      messagingSenderId: "267273489508",
      projectId: "alzfix-1",
      databaseURL:
          "https://alzfix-1-default-rtdb.europe-west1.firebasedatabase.app",
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ User granted permission for notifications');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('⚠️ User granted provisional permission');
  } else {
    print('❌ User declined or has not accepted permission');
  }

  // ✅ اطبع التوكن
  FirebaseMessaging.instance.getToken().then((token) {
    print("📱 Device Token: $token");
  });

  // ✅ اسمع للإشعارات داخل التطبيق
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🔔 Foreground Notification");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("📲 App opened from notification");
  });

  runApp(MyApp());
}

Future<void> loadTokenFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ApiConstants.Token = prefs.getString('token');
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔙 Notification received in background:");
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF191919),
            iconTheme: IconThemeData(
              color: Color(0xFFA27EFC),
            )),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFA27EFC),
          onPrimary: Colors.white,
          secondary: Color(0xFF292929),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFFD0D2D1),
        ),

        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.deepPurple,
          behavior: SnackBarBehavior.floating,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          actionTextColor: Color(0xFFA27EFC),
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        scaffoldBackgroundColor: Color(0xFF191919),
        fontFamily: 'Inter',
        // Make sure to add Inter font to pubspec.yaml
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF292929),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
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
        TypeMedicine.routeName: (context) => TypeMedicine(),
        HomePatient.routeName: (context) => HomePatient(),
        HomeDoctorScreen.routeName: (context) => HomeDoctorScreen(),
        //   aya
        DoctorHomeScreen.routeName: (context) => DoctorHomeScreen(),
        PillReportScreen2.routeName: (context) => PillReportScreen2(),
        PillReportScreen.routeName: (context) => PillReportScreen(),
        HomePage.routeName: (context) => HomePage(),
        MedicationFormScreen.routeName: (context) => MedicationFormScreen(),
        RadiologyReportScreen.routeName: (context) => RadiologyReportScreen(),
        EditUserScreen.routeName: (context) => EditUserScreen()
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
