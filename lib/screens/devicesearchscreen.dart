import 'package:flutter/material.dart';
import 'package:all_bluetooth/all_bluetooth.dart';

final allBluetooth = AllBluetooth();  // Global instance of AllBluetooth

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),  // Set HomeScreen as the starting point
    );
  }
}
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BluetoothDevice> devices = [];  // List to store discovered devices

  @override
  void initState() {
    super.initState();
    allBluetooth.startDiscovery();  // Start device discovery
    allBluetooth.discoverDevices.listen((device) {
      setState(() {
        if (!devices.any((d) => d.address == device.address)) {
          devices.add(device);  // Add each new device to the list
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Devices')),
      body: devices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  title: Text(device.name ?? "Unknown Device"),
                  subtitle: Text(device.address),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DeviceScreen(device: device),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => allBluetooth.startDiscovery(),
        child: Icon(Icons.search),
      ),
    );
  }
}
class DeviceScreen extends StatelessWidget {
  final BluetoothDevice device;

  DeviceScreen({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name ?? "Unknown Device"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Connect'),
              onPressed: () async {
                await allBluetooth.connectToDevice(device.address);
              },
            ),

          ],
        ),
      ),
    );
  }
}