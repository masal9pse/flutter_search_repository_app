// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart'
    as _i1;
import 'package:flutter_engineer_codecheck/presentation/view/pages/create_issue_code.dart'
    as _i2;
import 'package:flutter_engineer_codecheck/presentation/view/pages/dashboard_page.dart'
    as _i4;
import 'package:flutter_engineer_codecheck/presentation/view/pages/favorite_page.dart'
    as _i5;
import 'package:flutter_engineer_codecheck/presentation/view/pages/my_page.dart'
    as _i7;
import 'package:flutter_engineer_codecheck/presentation/view/pages/posts_page.dart'
    as _i8;
import 'package:flutter_engineer_codecheck/presentation/view/pages/root_page.dart'
    as _i10;
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart'
    as _i6;
import 'package:flutter_engineer_codecheck/presentation/view/pages/swipe_router.dart'
    as _i12;
import 'package:flutter_engineer_codecheck/presentation/view/pages/tabs/books_tab.dart'
    as _i3;
import 'package:flutter_engineer_codecheck/presentation/view/pages/tabs/profile_tab.dart'
    as _i9;
import 'package:flutter_engineer_codecheck/presentation/view/pages/tabs/settings_tab.dart'
    as _i11;
import 'package:flutter_engineer_codecheck/presentation/view/pages/upper_dashboard_page.dart'
    as _i13;
import 'package:flutter_engineer_codecheck/presentation/view/pages/users_page.dart'
    as _i14;

/// generated route for
/// [_i1.ApiShowPage]
class ApiShowRoute extends _i15.PageRouteInfo<ApiShowRouteArgs> {
  ApiShowRoute({
    _i16.Key? key,
    String name = 'masato is god',
    List<_i15.PageRouteInfo>? children,
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

  static _i15.PageInfo page = _i15.PageInfo(
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

  final _i16.Key? key;

  final String name;

  @override
  String toString() {
    return 'ApiShowRouteArgs{key: $key, name: $name}';
  }
}

/// generated route for
/// [_i1.ApiShowRouterPage]
class ApiShowRouterRoute extends _i15.PageRouteInfo<void> {
  const ApiShowRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ApiShowRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApiShowRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.ApiShowRouterPage();
    },
  );
}

/// generated route for
/// [_i2.BoardRouterPage]
class BoardRouterRoute extends _i15.PageRouteInfo<void> {
  const BoardRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          BoardRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'BoardRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.BoardRouterPage();
    },
  );
}

/// generated route for
/// [_i3.BooksTab]
class BooksTab extends _i15.PageRouteInfo<void> {
  const BooksTab({List<_i15.PageRouteInfo>? children})
      : super(
          BooksTab.name,
          initialChildren: children,
        );

  static const String name = 'BooksTab';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.BooksTab();
    },
  );
}

/// generated route for
/// [_i4.DashboardRouterPage]
class DashboardRouterRoute extends _i15.PageRouteInfo<void> {
  const DashboardRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          DashboardRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i5.FavoritePage]
class FavoriteRoute extends _i15.PageRouteInfo<void> {
  const FavoriteRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FavoriteRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoriteRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.FavoritePage();
    },
  );
}

/// generated route for
/// [_i2.FirstDetailPage]
class FirstDetailRoute extends _i15.PageRouteInfo<void> {
  const FirstDetailRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FirstDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstDetailRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.FirstDetailPage();
    },
  );
}

/// generated route for
/// [_i2.FirstPage]
class FirstRoute extends _i15.PageRouteInfo<void> {
  const FirstRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FirstRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.FirstPage();
    },
  );
}

/// generated route for
/// [_i2.FirstRouterPage]
class FirstRouterRoute extends _i15.PageRouteInfo<void> {
  const FirstRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          FirstRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.FirstRouterPage();
    },
  );
}

/// generated route for
/// [_i6.HomeRouterPage]
class HomeRouterRoute extends _i15.PageRouteInfo<void> {
  const HomeRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeRouterPage();
    },
  );
}

/// generated route for
/// [_i7.MyPage]
class MyRoute extends _i15.PageRouteInfo<void> {
  const MyRoute({List<_i15.PageRouteInfo>? children})
      : super(
          MyRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.MyPage();
    },
  );
}

/// generated route for
/// [_i8.PostsPage]
class PostsRoute extends _i15.PageRouteInfo<PostsRouteArgs> {
  PostsRoute({
    _i16.Key? key,
    int id = -1,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          PostsRoute.name,
          args: PostsRouteArgs(
            key: key,
            id: id,
          ),
          initialChildren: children,
        );

  static const String name = 'PostsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<PostsRouteArgs>(orElse: () => const PostsRouteArgs());
      return _i8.PostsPage(
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

  final _i16.Key? key;

  final int id;

  @override
  String toString() {
    return 'PostsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i9.ProfileTab]
class ProfileTab extends _i15.PageRouteInfo<void> {
  const ProfileTab({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.ProfileTab();
    },
  );
}

/// generated route for
/// [_i10.RootPage]
class RootRoute extends _i15.PageRouteInfo<void> {
  const RootRoute({List<_i15.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.RootPage();
    },
  );
}

/// generated route for
/// [_i6.SearchApiListPage]
class SearchApiListRoute extends _i15.PageRouteInfo<void> {
  const SearchApiListRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SearchApiListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchApiListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.SearchApiListPage();
    },
  );
}

/// generated route for
/// [_i2.SecondPage]
class SecondRoute extends _i15.PageRouteInfo<void> {
  const SecondRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SecondRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecondRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.SecondPage();
    },
  );
}

/// generated route for
/// [_i11.SettingsTab]
class SettingsTab extends _i15.PageRouteInfo<void> {
  const SettingsTab({List<_i15.PageRouteInfo>? children})
      : super(
          SettingsTab.name,
          initialChildren: children,
        );

  static const String name = 'SettingsTab';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsTab();
    },
  );
}

/// generated route for
/// [_i12.SwipePage]
class SwipeRoute extends _i15.PageRouteInfo<void> {
  const SwipeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          SwipeRoute.name,
          initialChildren: children,
        );

  static const String name = 'SwipeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SwipePage();
    },
  );
}

/// generated route for
/// [_i13.UpperDashboardRouterPage]
class UpperDashboardRouterRoute extends _i15.PageRouteInfo<void> {
  const UpperDashboardRouterRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UpperDashboardRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpperDashboardRouterRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.UpperDashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i14.UsersPage]
class UsersRoute extends _i15.PageRouteInfo<void> {
  const UsersRoute({List<_i15.PageRouteInfo>? children})
      : super(
          UsersRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsersRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.UsersPage();
    },
  );
}
