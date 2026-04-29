import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Singleton pattern - عشان ما يتعملش منه أكتر من instance
  static final SecureStorage _instance = SecureStorage._internal();
  factory SecureStorage() => _instance;
  SecureStorage._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    // إعدادات إضافية لزيادة الأمان (اختياري لكن موصى به)
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );
  // ==================== الكتابة ====================
  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      // print('✅ SecureStorage: Wrote $key');   // أزل التعليق في الـ Development فقط
    } catch (e) {
      print('❌ SecureStorage Write Error: $e');
      rethrow;
    }
  }

  // ==================== القراءة ====================
  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      // print('✅ SecureStorage: Read $key');    // أزل التعليق في الـ Development فقط
      return value;
    } catch (e) {
      print('❌ SecureStorage Read Error: $e');
      rethrow;
    }
  }

  // ==================== الحذف ====================
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      // print('✅ SecureStorage: Deleted $key');
    } catch (e) {
      print('❌ SecureStorage Delete Error: $e');
      rethrow;
    }
  }

  // ==================== حذف الكل ====================
  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      // print('✅ SecureStorage: All data deleted');
    } catch (e) {
      print('❌ SecureStorage DeleteAll Error: $e');
      rethrow;
    }
  }

  // ==================== التحقق من وجود مفتاح ====================
  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e) {
      print('❌ SecureStorage ContainsKey Error: $e');
      return false;
    }
  }

  // ==================== قراءة كل المفاتيح (للـ Debug فقط) ====================
  Future<Map<String, String>> readAll() async {
    try {
      return await _storage.readAll();
    } catch (e) {
      print('❌ SecureStorage ReadAll Error: $e');
      return {};
    }
  }
}
