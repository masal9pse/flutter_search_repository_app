// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart'
    as _i1;
import 'package:flutter_engineer_codecheck/presentation/view/pages/dashboard_page.dart'
    as _i2;
import 'package:flutter_engineer_codecheck/presentation/view/pages/favorite_page.dart'
    as _i3;
import 'package:flutter_engineer_codecheck/presentation/view/pages/my_page.dart'
    as _i5;
import 'package:flutter_engineer_codecheck/presentation/view/pages/posts_page.dart'
    as _i6;
import 'package:flutter_engineer_codecheck/presentation/view/pages/root_page.dart'
    as _i7;
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart'
    as _i4;
import 'package:flutter_engineer_codecheck/presentation/view/pages/unknown_page.dart'
    as _i8;
import 'package:flutter_engineer_codecheck/presentation/view/pages/users_page.dart'
    as _i9;

/// generated route for
/// [_i1.ApiShowPage]
class ApiShowRoute extends _i10.PageRouteInfo<ApiShowRouteArgs> {
  ApiShowRoute({
    _i11.Key? key,
    String name = 'masato is god',
    List<_i10.PageRouteInfo>? children,
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

  static _i10.PageInfo page = _i10.PageInfo(
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

  final _i11.Key? key;

  final String name;

  @override
  String toString() {
    return 'ApiShowRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i10.PageRouteInfo<void> {
  const DashboardRoute({List<_i10.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.FavoritePage]
class FavoriteRoute extends _i10.PageRouteInfo<void> {
  const FavoriteRoute({List<_i10.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.FavoritePage();
    },
  );
}

/// generated route for
/// [_i4.HomeRouterPage]
class HomeRouterRoute extends _i10.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeRouterPage();
    },
  );
}

/// generated route for
/// [_i5.MyPage]
class MyRoute extends _i10.PageRouteInfo<void> {
  const MyRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.MyPage();
    },
  );
}

/// generated route for
/// [_i6.PostsPage]
class PostsRoute extends _i10.PageRouteInfo<void> {
  const PostsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PostsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PostsRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i6.PostsPage();
    },
  );
}

/// generated route for
/// [_i7.RootPage]
class RootRoute extends _i10.PageRouteInfo<void> {
  const RootRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.RootPage();
    },
  );
}

/// generated route for
/// [_i4.SearchApiListPage]
class SearchApiListRoute extends _i10.PageRouteInfo<void> {
  const SearchApiListRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SearchApiListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchApiListRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.SearchApiListPage();
    },
  );
}

/// generated route for
/// [_i8.UnknownPage]
class UnknownRoute extends _i10.PageRouteInfo<void> {
  const UnknownRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UnknownRoute.name,
          initialChildren: children,
        );

  static const String name = 'UnknownRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.UnknownPage();
    },
  );
}

/// generated route for
/// [_i9.UsersPage]
class UsersRoute extends _i10.PageRouteInfo<void> {
  const UsersRoute({List<_i10.PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.UsersPage();
    },
  );
}
