import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/screens/repo_detail_screen.dart';
import 'package:flutter_engineer_codecheck/search_repo/screens/repo_search_screen.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

@TypedGoRoute<SearchRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DetailRoute>(path: 'detail/:owner/:repo'),
  ],
)
@immutable
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RepoSearchScreen();
}

@immutable
class DetailRoute extends GoRouteData with $DetailRoute {
  const DetailRoute({required this.owner, required this.repo});

  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RepoDetailScreen(owner: owner, repo: repo);
}

final router = GoRouter(
  routes: $appRoutes,
);
