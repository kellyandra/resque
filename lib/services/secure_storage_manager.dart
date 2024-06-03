import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:math';

// Manager class for secure storage operations, focusing on mesh network configuration.
class SecureStorageManager {
  // Single instance of FlutterSecureStorage to be used throughout the application.
  static final _storage = const FlutterSecureStorage();

  /// Generates a random key using strong random number generation.
  static String generateRandomKey() {
    var rand = Random.secure(); // Secure random generator.
    var bytes = List<int>.generate(16, (_) => rand.nextInt(256)); // Generates 16 random bytes.
    return base64Url.encode(bytes); // Encodes bytes to a URL-safe base64 string.
  }

  /// Saves a value securely in the storage using a specified key.
  static Future<void> saveNetworkKey(String key, String value) async {
    try {
      await _storage.write(key: key, value: value); // Writes the key-value pair securely.
    } catch (e) {
      print('Error saving key $key: $e'); // Error handling.
    }
  }

  /// Retrieves a value securely from the storage using a specified key.
  static Future<String?> getNetworkKey(String key) async {
    try {
      String? value = await _storage.read(key: key); // Reads the value using the key.
      if (value == null) {
        // If no value is found, a default value is set and saved.
        value = '{"resque_mesh": 91234"}';
        await _storage.write(key: key, value: value);
      }
      return value; // Returns the value found or the default value.
    } catch (e) {
      print('Error retrieving key $key: $e'); // Error handling.
      return null;
    }
  }

  /// Sets up default configuration values and saves them securely.
  static Future<void> setupDefaultConfig() async {
    try {
      // Generates random keys for network and application.
      String networkKey = generateRandomKey();
      String applicationKey = generateRandomKey();

      // Encodes the configuration data as a JSON string.
      String defaultConfigJson = jsonEncode({
        'networkKey': networkKey,
        'applicationKey': applicationKey,
        'unicastAddressStart': '0x0001'
      });

      // Saves the default configuration in secure storage.
      await saveNetworkKey('mesh_network_config', defaultConfigJson);
      
    } catch (e) {
      print('Error setting up default configuration: $e'); // Error handling.
    }
  }
}
