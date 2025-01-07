// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart'
    as _i5;
import 'package:flutter_engineer_codecheck/presentation/view/pages/api_show_page.dart'
    as _i1;
import 'package:flutter_engineer_codecheck/presentation/view/pages/search_api_list_page.dart'
    as _i2;

/// generated route for
/// [_i1.ApiShowPage]
class ApiShowRoute extends _i3.PageRouteInfo<ApiShowRouteArgs> {
  ApiShowRoute({
    _i4.Key? key,
    required _i5.Item item,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ApiShowRoute.name,
          args: ApiShowRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'ApiShowRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ApiShowRouteArgs>();
      return _i1.ApiShowPage(
        key: args.key,
        item: args.item,
      );
    },
  );
}

class ApiShowRouteArgs {
  const ApiShowRouteArgs({
    this.key,
    required this.item,
  });

  final _i4.Key? key;

  final _i5.Item item;

  @override
  String toString() {
    return 'ApiShowRouteArgs{key: $key, item: $item}';
  }
}

/// generated route for
/// [_i2.SearchApiListPage]
class SearchApiListRoute extends _i3.PageRouteInfo<void> {
  const SearchApiListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          SearchApiListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchApiListRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.SearchApiListPage();
    },
  );
}
