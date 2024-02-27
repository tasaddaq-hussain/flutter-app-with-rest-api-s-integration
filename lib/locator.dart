import 'package:get_it/get_it.dart';
import 'package:meta_melon_task_app/services/api_service.dart';
import 'package:meta_melon_task_app/ui/home_viewmodel.dart';
 
GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Services
 
  locator.registerSingleton<ApiService>(ApiService());

  // Viewmodel
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
 }