
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class Storage {
  const Storage._();

  static final GetStorage _storage = GetStorage('one-click');

  static GetStorage get storage => _storage;

  static Future<void> saveValue(String key, dynamic value) =>
      _storage.writeIfNull(key, value);

  static T? getValue<T>(String key) => _storage.read<T>(key);

  static bool hasData(String key) => _storage.hasData(key);

  static Future<void> removeValue(String key) => _storage.remove(key);

  static Future<void> clearStorage() => _storage.erase();
}
