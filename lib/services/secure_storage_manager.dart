// lib/services/secure_storage_manager.dart
// ignore_for_file: avoid_print, prefer_const_declarations

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:math';

class SecureStorageManager {
  static final _storage = const FlutterSecureStorage();

  static String generateRandomKey() {
    var rand = Random.secure();
    var bytes = List<int>.generate(16, (_) => rand.nextInt(256));
    return base64Url.encode(bytes);
  }


  /// Saves a value securely using a specified key.
  static Future<void> saveNetworkKey(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      print('Error saving key $key: $e');
    }
    
  }

  /// Retrieves a value securely using a specified key.
  static Future<String?> getNetworkKey(String key) async {
    try {
      String? value = await _storage.read(key: key);
      if (value == null) {
        value = '{"resque_mesh": 91234"}';
        await _storage.write(key: key, value: value);
      }
      return value;
    } catch (e) {
      print('Error retrieving key $key: $e');
      return null;
    }
  }

  static Future<void> setupDefaultConfig() async {
    try {
      String networkKey = generateRandomKey();
      String applicationKey = generateRandomKey();
      String defaultConfigJson = jsonEncode({
        'networkKey': networkKey,
        'applicationKey': applicationKey,
        'unicastAddressStart': '0x0001'
      });

      await saveNetworkKey('mesh_network_config', defaultConfigJson);
      
    } catch (e) {
      print('Error setting up default configuration: $e');
    }
    
  }
}
