import 'package:flutter/material.dart';
import 'package:trial/homepage.dart';

import 'package:trial/suggestfood.dart';
import 'workout.dart';
import 'profile.dart'; // Import the WorkoutListPage
// import 'login.dart'; // Import the LoginPage

void main() {
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
      home: HomePage(), // Set LoginPage as the home screen
      debugShowCheckedModeBanner: false,
    );
  }
}