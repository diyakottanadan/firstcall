import 'package:firstcall/pages/forestform.dart';
import 'package:firstcall/pages/hospitalform.dart';
import 'package:firstcall/pages/policeform.dart';
import 'package:firstcall/pages/rescueform.dart';
import 'package:firstcall/pages/workshopform.dart';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'pages/college/mainpage.dart';
import 'pages/college_registration.dart';
import 'pages/customer_registration.dart';
import 'pages/login.dart';
import 'pages/student/mainpage.dart';
import 'pages/usertype.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.yellow,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 21,
                fontWeight: FontWeight.w500)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
            textStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      home: OnboardingScreen(),
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginPage(),
        '/usertype': (context) => UserTypePage(),
        '/user_registration': (context) => UserFormPage(),
        '/college_registration': (context) => CollegeRegistration(),
        '/studentpage': (context) => MainPage(),
        '/collegepage': (context) => CollegeMain(),
        '/hospital_registration': (context) => HospitalFormPage(),
        '/forest_registration': (context) => ForestFormPage(),
        '/police_registration': (context) => PoliceRegistrationForm(),
        '/rescue_registration': (context) => RescueFormPage(),
        '/workshop_registration': (context) => WorkshopFormPage(),

      },
    );
  }
}
