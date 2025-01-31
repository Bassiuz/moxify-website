import 'package:MoxifyMTG/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, path: '/', page: MyHomeRoute.page),
        AutoRoute(path: '/app', page: AppDeeplinkRoute.page),
      ];
}
