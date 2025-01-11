// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart'
    as _i1;
import 'package:flutter_engineer_codecheck/presentation/view/pages/favorite_page.dart'
    as _i2;
import 'package:flutter_engineer_codecheck/presentation/view/pages/my_page.dart'
    as _i4;
import 'package:flutter_engineer_codecheck/presentation/view/pages/root_page.dart'
    as _i5;
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart'
    as _i3;

/// generated route for
/// [_i1.ApiShowPage]
class ApiShowRoute extends _i6.PageRouteInfo<ApiShowRouteArgs> {
  ApiShowRoute({
    _i7.Key? key,
    String name = 'masato is god',
    List<_i6.PageRouteInfo>? children,
  }) : super(
          ApiShowRoute.name,
          args: ApiShowRouteArgs(
            key: key,
            name: name,
          ),
          rawQueryParams: {'name': name},
          initialChildren: children,
        );

  static const String name = 'ApiShowRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ApiShowRouteArgs>(
          orElse: () => ApiShowRouteArgs(
                  name: queryParams.getString(
                'name',
                'masato is god',
              )));
      return _i1.ApiShowPage(
        key: args.key,
        name: args.name,
      );
    },
  );
}

class ApiShowRouteArgs {
  const ApiShowRouteArgs({
    this.key,
    this.name = 'masato is god',
  });

  final _i7.Key? key;

  final String name;

  @override
  String toString() {
    return 'ApiShowRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i2.FavoritePage]
class FavoriteRoute extends _i6.PageRouteInfo<void> {
  const FavoriteRoute({List<_i6.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.FavoritePage();
    },
  );
}

/// generated route for
/// [_i3.HomeRouterPage]
class HomeRouterRoute extends _i6.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeRouterPage();
    },
  );
}

/// generated route for
/// [_i4.MyPage]
class MyRoute extends _i6.PageRouteInfo<void> {
  const MyRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MyPage();
    },
  );
}

/// generated route for
/// [_i5.RootPage]
class RootRoute extends _i6.PageRouteInfo<void> {
  const RootRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.RootPage();
    },
  );
}

/// generated route for
/// [_i3.SearchApiListPage]
class SearchApiListRoute extends _i6.PageRouteInfo<void> {
  const SearchApiListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SearchApiListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchApiListRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.SearchApiListPage();
    },
  );
}
