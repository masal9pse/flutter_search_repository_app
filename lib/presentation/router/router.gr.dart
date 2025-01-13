// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
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
import 'package:flutter_engineer_codecheck/presentation/view/pages/users_page.dart'
    as _i8;

/// generated route for
/// [_i1.ApiShowPage]
class ApiShowRoute extends _i9.PageRouteInfo<ApiShowRouteArgs> {
  ApiShowRoute({
    _i10.Key? key,
    String name = 'masato is god',
    List<_i9.PageRouteInfo>? children,
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

  static _i9.PageInfo page = _i9.PageInfo(
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

  final _i10.Key? key;

  final String name;

  @override
  String toString() {
    return 'ApiShowRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i1.ApiShowRouterPage]
class ApiShowRouterRoute extends _i9.PageRouteInfo<void> {
  const ApiShowRouterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          ApiShowRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApiShowRouterRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.ApiShowRouterPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardRouterPage]
class DashboardRouterRoute extends _i9.PageRouteInfo<void> {
  const DashboardRouterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          DashboardRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRouterRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i3.FavoritePage]
class FavoriteRoute extends _i9.PageRouteInfo<void> {
  const FavoriteRoute({List<_i9.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.FavoritePage();
    },
  );
}

/// generated route for
/// [_i4.HomeRouterPage]
class HomeRouterRoute extends _i9.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i9.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeRouterPage();
    },
  );
}

/// generated route for
/// [_i5.MyPage]
class MyRoute extends _i9.PageRouteInfo<void> {
  const MyRoute({List<_i9.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.MyPage();
    },
  );
}

/// generated route for
/// [_i6.PostsPage]
class PostsRoute extends _i9.PageRouteInfo<PostsRouteArgs> {
  PostsRoute({
    _i10.Key? key,
    int id = -1,
    List<_i9.PageRouteInfo>? children,
  }) : super(
          PostsRoute.name,
          args: PostsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PostsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<PostsRouteArgs>(orElse: () => const PostsRouteArgs());
      return _i6.PostsPage(
        key: args.key,
        id: args.id,
      );
    },
  );
}

class PostsRouteArgs {
  const PostsRouteArgs({
    this.key,
    this.id = -1,
  });

  final _i10.Key? key;

  final int id;

  @override
  String toString() {
    return 'PostsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i7.RootPage]
class RootRoute extends _i9.PageRouteInfo<void> {
  const RootRoute({List<_i9.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.RootPage();
    },
  );
}

/// generated route for
/// [_i4.SearchApiListPage]
class SearchApiListRoute extends _i9.PageRouteInfo<void> {
  const SearchApiListRoute({List<_i9.PageRouteInfo>? children})
      : super(
          SearchApiListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchApiListRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.SearchApiListPage();
    },
  );
}

/// generated route for
/// [_i8.UsersPage]
class UsersRoute extends _i9.PageRouteInfo<void> {
  const UsersRoute({List<_i9.PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.UsersPage();
    },
  );
}
