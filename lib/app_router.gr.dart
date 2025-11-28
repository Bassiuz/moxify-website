// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:MoxifyMTG/app_deeplink/app_deeplink_page.dart' as _i1;
import 'package:MoxifyMTG/homepage/homepage.dart' as _i3;
import 'package:MoxifyMTG/loan/loan_landing_page.dart' as _i2;
import 'package:MoxifyMTG/qr_landing/qr_landing_page.dart' as _i4;

/// generated route for
/// [_i1.AppDeeplinkPage]
class AppDeeplinkRoute extends _i5.PageRouteInfo<void> {
  const AppDeeplinkRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AppDeeplinkRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppDeeplinkRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppDeeplinkPage();
    },
  );
}

/// generated route for
/// [_i2.LoanLandingPage]
class LoanLandingRoute extends _i5.PageRouteInfo<LoanLandingRouteArgs> {
  LoanLandingRoute({
    _i6.Key? key,
    String? importData,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoanLandingRoute.name,
          args: LoanLandingRouteArgs(
            key: key,
            importData: importData,
          ),
          rawQueryParams: {'d': importData},
          initialChildren: children,
        );

  static const String name = 'LoanLandingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<LoanLandingRouteArgs>(
          orElse: () =>
              LoanLandingRouteArgs(importData: queryParams.optString('d')));
      return _i2.LoanLandingPage(
        key: args.key,
        importData: args.importData,
      );
    },
  );
}

class LoanLandingRouteArgs {
  const LoanLandingRouteArgs({
    this.key,
    this.importData,
  });

  final _i6.Key? key;

  final String? importData;

  @override
  String toString() {
    return 'LoanLandingRouteArgs{key: $key, importData: $importData}';
  }
}

/// generated route for
/// [_i3.MyHomePage]
class MyHomeRoute extends _i5.PageRouteInfo<void> {
  const MyHomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.MyHomePage();
    },
  );
}

/// generated route for
/// [_i4.QRLandingPage]
class QRLandingRoute extends _i5.PageRouteInfo<void> {
  const QRLandingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          QRLandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'QRLandingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.QRLandingPage();
    },
  );
}
