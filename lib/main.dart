import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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
      home: const FindDevicesScreen(),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Devices"),
      ),
      body: RefreshIndicator(
        onRefresh: () => FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: const [],
                builder: (c, snapshot) {
                  // Handle null and check if there is data
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: snapshot.data!.map((d) => ListTile(
                            title: Text(d.name ?? 'Unknown Device'), // Safe handling of potentially null device name
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
            ],
          ),
        ),
      ),
    );
  }
}
