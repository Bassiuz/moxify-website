// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:MoxifyMTG/app_deeplink/app_deeplink_page.dart' as _i1;
import 'package:MoxifyMTG/homepage/homepage.dart' as _i2;

/// generated route for
/// [_i1.AppDeeplinkPage]
class AppDeeplinkRoute extends _i3.PageRouteInfo<void> {
  const AppDeeplinkRoute({List<_i3.PageRouteInfo>? children})
      : super(
          AppDeeplinkRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppDeeplinkRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppDeeplinkPage();
    },
  );
}

/// generated route for
/// [_i2.MyHomePage]
class MyHomeRoute extends _i3.PageRouteInfo<void> {
  const MyHomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MyHomePage();
    },
  );
}
