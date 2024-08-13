import 'package:get_it/get_it.dart';
import 'package:travel_chronicle/data/event_repo/event_api.dart';
import 'package:travel_chronicle/data/event_repo/event_repository.dart';
import 'package:travel_chronicle/data/storage/prefs_storage.dart';
import 'package:travel_chronicle/data/storage/storage.dart';
import 'package:travel_chronicle/data/user_repo/user_api.dart';
import 'package:travel_chronicle/data/user_repo/user_repository.dart';

final _locator = GetIt.instance;

IUserRepository get userRepository => _locator<IUserRepository>();

IStorage get storage => _locator<IStorage>();

IEventRepository get eventRepository => _locator<IEventRepository>();




abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton<IStorage>(() => PrefsStorage());
    _locator.registerLazySingleton<IUserRepository>(() => UserApi());

    
    _locator.registerLazySingleton<IEventRepository>(() => EventApi());
  }
}



