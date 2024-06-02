// import 'package:flutter_blue/flutter_blue.dart';

// class BluetoothManager {
//   final FlutterBlue _flutterBlue = FlutterBlue.instance;

//   Stream<List<BluetoothDevice>> getConnectedDevices() {
//     return Stream.periodic(const Duration(seconds: 2))
//         .asyncMap((_) => _flutterBlue.connectedDevices);
//   }

//   void startScan() {
//     _flutterBlue.startScan(timeout: const Duration(seconds: 4));
//   }
// }

