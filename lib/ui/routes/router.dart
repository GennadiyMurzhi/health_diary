import 'package:auto_route/auto_route.dart';
import 'package:health_diary/ui/authorization/authorization_screen.dart';
import 'package:health_diary/ui/create_diary/create_diary_screen.dart';
import 'package:health_diary/ui/main/main_screen.dart';
import 'package:health_diary/ui/preset_selection/preset_selection_screen.dart';
import 'package:health_diary/ui/splash_screen.dart';
import 'package:health_diary/ui/user_info/user_info_screen.dart';

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
          page: UserInfoRoute.page,
          path: '/user-info-screen',
        ),
        AutoRoute(
          page: UserInfoRoute.page,
          path: '/preset-selection-screen',
        ),
        AutoRoute(
          page: UserInfoRoute.page,
          path: '/create-diary-screen',
        ),
        AutoRoute(
          page: MainRoute.page,
          path: '/main-screen',
        ),
      ];
}
