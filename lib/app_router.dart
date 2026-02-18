import 'package:MoxifyMTG/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, path: '/', page: MyHomeRoute.page),
        AutoRoute(path: '/app', page: AppDeeplinkRoute.page),
        AutoRoute(path: '/loan', page: LoanLandingRoute.page),
        AutoRoute(path: '/qr', page: QRLandingRoute.page),
        AutoRoute(path: '/extensions', page: ExtensionsRoute.page),
      ];
}
