import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const _keyToken = 'access_token';

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  Future<void> saveUserCredential({String? username, String? email}) async {
    if (username != null) {
      await _storage.write(key: 'username', value: username);
    }
    if (email != null) {
      await _storage.write(key: 'email', value: email);
    }
  }
}
