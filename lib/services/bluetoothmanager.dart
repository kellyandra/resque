//import 'package:flutter_blue/flutter_blue.dart';

class BluetoothManager {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  Stream<List<BluetoothDevice>> getConnectedDevices() {
    return Stream.periodic(Duration(seconds: 2))
        .asyncMap((_) => _flutterBlue.connectedDevices);
  }

  void startScan() {
    _flutterBlue.startScan(timeout: Duration(seconds: 4));
  }
}

