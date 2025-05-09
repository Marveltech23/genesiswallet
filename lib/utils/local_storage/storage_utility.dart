import 'package:get_storage/get_storage.dart';

class MlocalStorage {
  static final MlocalStorage _instance = MlocalStorage._internal();

  factory MlocalStorage() {
    return _instance;
  }

  MlocalStorage._internal();

  final _storage = GetStorage();

  //Generic method to save data

  Future<void> saveDate<T>(String key, T value) async {
    await _storage.write(key, value);
  }

// Generic method to read

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  // Generic method to remove data

  Future<void> removData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
