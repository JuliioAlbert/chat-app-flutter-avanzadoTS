import 'package:chat_app/data/services/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInyection {
  static init() {
    GetIt getIt = GetIt.instance;
    getIt.registerSingleton<AuthRepository>(AuthRepository());
    getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  }
}
