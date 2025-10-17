// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:MoxifyMTG/app_deeplink/app_deeplink_page.dart' as _i1;
import 'package:MoxifyMTG/homepage/homepage.dart' as _i2;
import 'package:MoxifyMTG/qr_landing/qr_landing_page.dart' as _i3;

/// generated route for
/// [_i1.AppDeeplinkPage]
class AppDeeplinkRoute extends _i4.PageRouteInfo<void> {
  const AppDeeplinkRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AppDeeplinkRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppDeeplinkRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppDeeplinkPage();
    },
  );
}

/// generated route for
/// [_i2.MyHomePage]
class MyHomeRoute extends _i4.PageRouteInfo<void> {
  const MyHomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.MyHomePage();
    },
  );
}

/// generated route for
/// [_i3.QRLandingPage]
class QRLandingRoute extends _i4.PageRouteInfo<void> {
  const QRLandingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          QRLandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'QRLandingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.QRLandingPage();
    },
  );
}
