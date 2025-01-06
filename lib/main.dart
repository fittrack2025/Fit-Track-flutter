import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:trial/bmi.dart';
import 'package:trial/chat.dart';
import 'package:trial/homepage.dart';


import 'login.dart';
import 'reminder.dart';


// Import the WorkoutListPage
// import 'login.dart'; // Import the LoginPage

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'AIzaSyADsfi40MW1rrMmb5sEdA72_Ar9AoDY4q0');
  await Alarm.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FIt-Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Loginpage(), // Set LoginPage as the home screen
      debugShowCheckedModeBanner: false,
    );
  }
}
