import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resque/screens/messagingscreen.dart';

import '../main.dart';

// StatefulWidget for managing Bluetooth bonding processes.
class BondScreen extends StatefulWidget {
  const BondScreen({super.key});

  @override
  State<BondScreen> createState() => _BondScreenState();
}

class _BondScreenState extends State<BondScreen> {
  final bondedDevices = ValueNotifier(<BluetoothDevice>[]); // Listens to changes in bonded devices list.

  bool isListening = false; // Tracks if the device is currently listening for connections.

  @override
  void initState() {
    super.initState();
    // Requests necessary Bluetooth permissions on initialization.
    Future.wait([
      Permission.bluetooth.request(),
      Permission.bluetoothScan.request(),
      Permission.bluetoothConnect.request(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: allBluetooth.streamBluetoothState,
        builder: (context, snapshot) {
          final bluetoothOn = snapshot.data ?? false; // Checks if Bluetooth is turned on.
          return Scaffold(
            appBar: AppBar(
              title: const Text("Bluetooth Connect"),
            ),
            floatingActionButton: switch (isListening) {
              true => null, // No floating action button if already listening.
              false => FloatingActionButton(
                  onPressed: switch (bluetoothOn) {
                    false => null, // Disables button if Bluetooth is off.
                    true => () {
                        allBluetooth.startBluetoothServer();
                        setState(() => isListening = true); // Starts server and updates listening state.
                      },
                  },
                  backgroundColor:
                      bluetoothOn ? Theme.of(context).primaryColor : Colors.grey,
                  child: const Icon(Icons.wifi_tethering), // Icon for the floating action button.
                ),
            },
            body: isListening
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Listening for connections"), // Indicates listening status.
                        const CircularProgressIndicator(), // Loading indicator.
                        FloatingActionButton(
                          child: const Icon(Icons.stop), // Stop button.
                          onPressed: () {
                            allBluetooth.closeConnection(); // Stops Bluetooth connection.
                            setState(() {
                              isListening = false; // Updates listening state.
                            });
                          },
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              switch (bluetoothOn) {
                                true => "ON",
                                false => "off",
                              },
                              style: TextStyle(
                                  color: bluetoothOn ? Colors.green : Colors.red), // Color indicating Bluetooth status.
                            ),
                            ElevatedButton(
                              onPressed: switch (bluetoothOn) {
                                false => null, // Button disabled if Bluetooth is off.
                                true => () async {
                                    final devices =
                                        await allBluetooth.getBondedDevices();
                                    bondedDevices.value = devices; // Updates the list of bonded devices.
                                  },
                              },
                              child: const Text("Bonded Devices"), // Button to fetch bonded devices.
                            ),
                          ],
                        ),
                        if (!bluetoothOn)
                          const Center(
                            child: Text("Turn bluetooth on"), // Prompt to turn on Bluetooth.
                          ),
                        ValueListenableBuilder(
                            valueListenable: bondedDevices,
                            builder: (context, devices, child) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: bondedDevices.value.length,
                                  itemBuilder: (context, index) {
                                    final device = devices[index];
                                    return ListTile(
                                      title: Text(device.name), // Display name of the device.
                                      subtitle: Text(device.address), // Display address of the device.
                                      onTap: () {
                                        allBluetooth.connectToDevice(device.address); // Connects to the device.
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => MessageScreen(device: device), // Navigates to the messaging screen.
                                        ));
                                      },
                                    );
                                  },
                                ),
                              );
                            })
                      ],
                    ),
                  ),
          );
        });
  }
}
