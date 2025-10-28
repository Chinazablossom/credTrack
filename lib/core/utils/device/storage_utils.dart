import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceStorage {
  static final DeviceStorage _instance = DeviceStorage._internal();

  factory DeviceStorage() {
    return _instance;
  }

  DeviceStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const String keyUser = 'user_data';
  static const String keyUserId = 'user_id';
  static const String keyIsFirstTime = 'is_first_time';

  Future<void> saveData(String key, dynamic value) async {
    try {
      final encoded = jsonEncode(value);
      await _storage.write(key: key, value: encoded);
    } catch (_) {
      await _storage.write(key: key, value: value?.toString());
    }
  }

  Future<dynamic> readData(String key) async {
    final raw = await _storage.read(key: key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } catch (_) {
      if (raw == 'true') return true;
      if (raw == 'false') return false;
      final asNum = num.tryParse(raw);
      return asNum ?? raw;
    }
  }

  Future<void> removeData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }


  Future<dynamic> read(String key) => readData(key);

  Future<void> writeIfNull(String key, dynamic value) async {
    final existing = await _storage.read(key: key);
    if (existing == null) await saveData(key, value);
  }

  Future<void> debugPrintAll() async {
    try {
      final userJson = await readData(keyUser);
      final userId = await readData(keyUserId);

      debugPrint('user_id: $userId');
      debugPrint('user_data: $userJson');
    } catch (_) {}
  }
}
