import 'package:get_it/get_it.dart';
import 'package:health_diary/ui/routes/router.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();

  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}
