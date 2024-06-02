import 'package:flutter/material.dart';
import 'package:resque/alert_screen.dart';
import 'package:resque/chat_screen.dart';
import 'package:resque/main.dart';
import 'package:resque/screens/devicesearchscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenWidget(),
    );
  }
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  @override
  HomeScreenWidgetState createState() => HomeScreenWidgetState();
}

class HomeScreenWidgetState extends State<HomeScreenWidget> {
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
          IconButton(onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }, 
          
          icon: Image.asset('assets/Rectangle10.png'))
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
              flex: 2, // Adjust flex to change the space taken by the alert section
              child: _buildAlertSection(),
            ),
            Expanded(
              flex: 1, // Adjust flex to change the space taken by the buttons
              child: _buildButtonSection(),
            ),
          ],
        ),
      ),
    );
  }
  

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
            child: const Text('See details'),
            style: TextButton.styleFrom(foregroundColor: Colors.blueAccent),
          ),
          const Text(
            '3:30pm',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    return Column(
      children: [
        _buildButton('Alert History', Icons.notifications, Colors.red, AlertHistoryScreen()),
        const SizedBox(height: 10),
        _buildButton('Chat', Icons.chat, Colors.blue, ChatScreen()),
         const SizedBox(height: 10),
         _buildButton('Connect Devices', Icons.bluetooth_searching, Colors.green, HomeScreen()),
      ],
    );
  }

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
            minimumSize: Size(350, 50), // Manage width within Flexible constraints
          ),
        ),
      ),
    ],
  );
}
}