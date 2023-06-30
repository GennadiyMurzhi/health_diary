import 'package:auto_route/auto_route.dart';

import '../authorization/authorization_screen.dart';
import '../main/main_screen.dart';
import '../splash_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(
          page: AuthorizationRoute.page,
          path: '/auth-screen',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main-screen',
        ),
      ];
}
