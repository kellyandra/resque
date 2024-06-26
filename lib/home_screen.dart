import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resque/screens/bondeddevice.dart';
import 'alert_screen.dart';
import 'chat_screen.dart';
import 'screens/devicesearchscreen.dart';
import 'services/secure_storage_manager.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  // Initialize state
  @override
  void initState() {
    super.initState();
  }

  // Widget build method: sets up the UI structure
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("DASHBOARD", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }, 
            icon: Image.asset('assets/Rectangle10.png')
          )
        ],
      ),
      
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Color.fromARGB(255, 249, 236, 220)],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2, // Section for emergency alerts
              child: _buildAlertSection(),
            ),
            Expanded(
              flex: 1, // Section for buttons that navigate to other screens
              child: _buildButtonSection(),
            ),
          ],
        ),
      ),
    );
  }

  // Builds the alert section with notification information
  Widget _buildAlertSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Emergency Alerts',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            '1 New',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          const Text(
            'Severe Thunderstorm Warning in effect for Antigua and Barbuda',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
            child: const Text('See details'),
          ),
          const Text(
            '3:30pm',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Builds the section containing navigation buttons
  Widget _buildButtonSection() {
    return Column(
      children: [
        _buildButton('Alert History', Icons.notifications, Colors.red, AlertHistoryScreen()),
        const SizedBox(height: 10),
        _buildButton('Chat', Icons.chat, Colors.blue, ChatsScreen()),
        const SizedBox(height: 10),
        _buildButton('Connect Devices', Icons.bluetooth_searching, Colors.green, BondScreen()),
      ],
    );
  }

  // Helper function to build a styled button
  Widget _buildButton(String title, IconData icon, Color color, Widget page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            icon: Icon(icon, color: Colors.white),
            label: Text(title),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: Size(350, 50),
            ),
          ),
        ),
      ],
    );
  }
}
