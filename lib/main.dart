import 'package:flutter/material.dart';
import 'alert_screen.dart';
import 'home_screen.dart';
import 'splash_page.dart';
import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:permission_handler/permission_handler.dart';

// Entry point of the application.
void main() {
  runApp(const MyApp());
}

// Instance of AllBluetooth used for managing Bluetooth interactions.
final allBluetooth = AllBluetooth();

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // MaterialApp is the top-level widget that wraps several pages of the app.
    return MaterialApp(
      title: 'Resque', // Application title
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary theme color of the app
        useMaterial3: true, // Enables Material Design 3
      ),
      home: SplashScreen(), // Set SplashScreen as the initial page of the app
    );
  }
}

// SplashScreen displays an introductory animation or graphic while the app loads.
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay to show the splash screen before transitioning to the home screen.
    Future.delayed(const Duration(seconds: 3), () {
      // After 3 seconds, navigate to the HomeScreenWidget and remove the SplashScreen from the stack.
      Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (context) => const HomeScreenWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Render the SplashPage widget which shows the splash content.
    return SplashPage();
  }
}
