import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/start_screen.dart';
import 'screens/routine_selection_screen.dart';

void main() => runApp(PhysioApp());

class PhysioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physio Helper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins', // Use a custom font if available
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      // Show the Welcome Screen first
      home: WelcomeScreen(),
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/start': (context) => StartScreen(),
        '/routine': (context) => RoutineSelectionScreen(),
      },
    );
  }
}
