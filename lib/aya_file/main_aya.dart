import 'package:flutter/material.dart';
import 'package:mindpal/aya_file/bottles_screen_aya.dart';
import 'package:mindpal/aya_file/edit_user_screen_aya.dart';
import 'package:mindpal/aya_file/madel_aya/patient_aya.dart';
import 'package:mindpal/aya_file/screens_aya/edit_patient_screen_aya.dart';
import 'package:mindpal/aya_file/screens_aya/patient_details_screen_aya.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication Form',
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFFA892F5),
          onPrimary: Colors.white,
          secondary: Color(0xFF23232B),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Color(0xFF2C2C34),
          onSurface: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0xFF23232B),
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
          fillColor: Color(0xFF2C2C34),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: EditUserScreen(),

      // PatientDetailsScreen(
      //   patient: Patient(
      //     id: 'id',
      //     name: 'name',
      //     age: 25,
      //     phone: 'phone',
      //     email: 'email',
      //     address: 'address',
      //     medicalHistory: 'medicalHistory',
      //     currentMedications: 'currentMedications',
      //     allergies: 'allergies',
      //     familyHistory: 'familyHistory',
      //     lifestyle: 'lifestyle',
      //     socialHistory: 'socialHistory',
      //     occupationalHistory: 'occupationalHistory',
      //     developmentalHistory: 'developmentalHistory',
      //     psychiatricHistory: 'psychiatricHistory',
      //     substanceUse: 'substanceUse',
      //     legalHistory: 'legalHistory',
      //     culturalBackground: 'culturalBackground',
      //     spiritualBeliefs: 'spiritualBeliefs',
      //     supportSystem: 'supportSystem',
      //     copingMechanisms: 'copingMechanisms',
      //     riskFactors: 'riskFactors',
      //     protectiveFactors: 'protectiveFactors',
      //     strengths: 'strengths',
      //     challenges: 'challenges',
      //     goals: 'goals',
      //     treatmentPreferences: 'treatmentPreferences',
      //     barriersToTreatment: 'barriersToTreatment',
      //     motivation: 'motivation',
      //     expectations: 'expectations',
      //     concerns: 'concerns',
      //     questions: 'questions'
      //     , other: 'other',
      //   )
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}


