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
import 'package:mindpal/notifications/notification_service.dart';
import 'package:mindpal/services/api_constants.dart';
import 'package:mindpal/yosef/add_medicine.dart';
import 'package:mindpal/yosef/add_medicine_name.dart';
import 'package:mindpal/yosef/choose_bottle_update.dart';
import 'package:mindpal/yosef/choose_bottles.dart';
import 'package:mindpal/yosef/create_doctor_account.dart';
import 'package:mindpal/yosef/create_patientAccount.dart';
import 'package:mindpal/yosef/doctor_home_page.dart';
import 'package:mindpal/yosef/doctor_tab.dart';
import 'package:mindpal/yosef/done_medicine_screen.dart';
import 'package:mindpal/yosef/done_screen.dart';
import 'package:mindpal/yosef/hafez.dart';
import 'package:mindpal/yosef/home_admin_screen.dart';
import 'package:mindpal/yosef/home_doctor_screen.dart';
import 'package:mindpal/yosef/home_patient.dart';
import 'package:mindpal/yosef/home_patient_screen.dart';
import 'package:mindpal/yosef/home_tab.dart';
import 'package:mindpal/yosef/login_screen.dart';
import 'package:mindpal/yosef/patient_information.dart';
import 'package:mindpal/yosef/patient_tab.dart';
import 'package:mindpal/yosef/select_role.dart';
import 'package:mindpal/yosef/show_bottles.dart';
import 'package:mindpal/yosef/success_add_patient.dart';
import 'package:mindpal/yosef/success_page.dart';
import 'package:mindpal/yosef/type_medicine.dart';
import 'package:mindpal/yosef/view_medicine_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late FirebaseApp secondaryApp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // تحميل التوكن المحفوظ
  await loadTokenFromSharedPrefs();

  // ✅ تسجيل الهاندلر الخاص بالإشعارات في الخلفية (لازم قبل Firebase.initializeApp)
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ✅ تهيئة Firebase الأساسي
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ تهيئة تطبيق Firebase الثانوي (للتسجيل مثلاً)
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

  // ✅ إعداد Flutter Local Notifications + إنشاء القناة + listener داخلي
  await setupFlutterNotifications();

  // ✅ طلب صلاحيات الإشعارات
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("📲 App opened from notification");
    // Optional: navigate to details page based on message.data
  });

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('✅ Notifications authorized');
  } else {
    print('❌ Notifications not authorized');
  }

  // ✅ عرض توكن الجهاز
  FirebaseMessaging.instance.getToken().then((token) {
    print("📱 Device Token: $token");
  });

  String? token = prefs.getString('token');
  String? role = prefs.getString('role');

  Widget home;

  if (token != null && role != null) {
    switch (role) {
      case 'doctor':
        home = HomeDoctorScreen();
        break;
      case 'patient':
        home = HomePatientScreen();
        break;
      case 'admin':
        home = HomeAdminScreen();
        break;
      default:
        home = LoginScreen();
    }
  } else {
    home = LoginScreen();
  }

  runApp(MyApp(home: home));
}

Future<void> loadTokenFromSharedPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ApiConstants.Token = prefs.getString('token');
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final role = prefs.getString('role') ?? 'patient';

  if (role == 'patient' && message.data.isNotEmpty) {
    // ✅ استدعاء showInteractiveNotification بنفسك
    showInteractiveNotification(message);
  }

  print("🔙 Notification received in background:");
  print("✅ Full Data: ${message.data}");
}

class MyApp extends StatelessWidget {
  final Widget home;

  const MyApp({super.key, required this.home});

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
        ChooseBottleUpdate.routeName: (context) => ChooseBottleUpdate(),
        HomePatientScreen.routeName: (context) => HomePatientScreen(),
        ShowBottles.routeName: (context) => ShowBottles(),
        ViewMedicineScreen.routeName: (context) => ViewMedicineScreen(),
        //   aya
        DoctorHomeScreen.routeName: (context) => DoctorHomeScreen(),
        PillReportScreen2.routeName: (context) => PillReportScreen2(),
        PillReportScreen.routeName: (context) => PillReportScreen(),
        HomePage.routeName: (context) => HomePage(),
        MedicationFormScreen.routeName: (context) => MedicationFormScreen(),
        RadiologyReportScreen.routeName: (context) => RadiologyReportScreen(),
        EditUserScreen.routeName: (context) => EditUserScreen()
      },
      home: home,
    );
  }
}
