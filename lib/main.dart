import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:resque/splash_page.dart';

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
      // home: const FindDevicesScreen(),
      home: const FindDevicesScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a splash screen delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, 
      MaterialPageRoute(
        builder: (context) => HomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashPage(); // Display the SplashPage widget
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        ),
        body: Center(
          child:  Text('Welcome to the App!')
          ),
    );
  }
}


class FindDevicesScreen extends StatefulWidget {
  const FindDevicesScreen({super.key});

  @override
  FindDevicesScreenState createState() => FindDevicesScreenState();
}

class FindDevicesScreenState extends State<FindDevicesScreen> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];


  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    devicesList.clear(); // Clear the list before starting a new scan
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    flutterBlue.scanResults.listen((results) {
      setState(() {
        for (ScanResult r in results) {
          if (!devicesList.contains(r.device)) {
            devicesList.add(r.device);
          }
          
        }
      });
    }).onDone(() {
      flutterBlue.stopScan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Devices"),
          actions: [
            IconButton(
              onPressed: startScan, 
              icon: const Icon(Icons.refresh),
              )
          ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          startScan();
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(const Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: const [],
                builder: (c, snapshot) {
                  // Handle null and check if there is data
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: snapshot.data!.map((d) => ListTile(
                            title: Text(d.name.isEmpty ? 'Unknown Device' : d.name), // Safe handling of potentially null device name
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == BluetoothDeviceState.connected) {
                                    return TextButton(
                                      child: const Text('OPEN'),
                                      onPressed: () {}, // Logic for handling device connection or opening another screen
                                    );
                                  }
                                  return Text(snapshot.data.toString()); // Safely handling the trailing text
                                }
                                return const Text('State Unknown'); // Fallback text if state data is missing
                              },
                            ),
                          )).toList(),
                    );
                  } else {
                    // Handling the case when there are no devices or data is not ready
                    return const Center(child: Text("No devices found or waiting for data."));
                  }
                },
              ),
              Column(
                children: devicesList.map((device) {
                  return ListTile(
                    title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
                    subtitle: Text(device.id.toString()),
                    onTap: () {

                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
