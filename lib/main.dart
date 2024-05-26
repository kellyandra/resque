// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:resque/alert_screen.dart';
import 'package:resque/home_screen.dart';
import 'package:resque/splash_page.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BT Messaging App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      // home: const DeviceScreen(),
      home: SplashScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a splash screen delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (context) => HomeScreenWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage(); // Display the SplashPage widget
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        ),
        body: const Center(
          child:  Text('Welcome to the App!')
          ),
    );
  }
}
