// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $searchRoute,
    ];

RouteBase get $searchRoute => GoRouteData.$route(
      path: '/',
      factory: $SearchRoute._fromState,
      routes: [
        GoRouteData.$route(
          path: 'detail/:owner/:repo',
          factory: $DetailRoute._fromState,
        ),
      ],
    );

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $DetailRoute on GoRouteData {
  static DetailRoute _fromState(GoRouterState state) => DetailRoute(
        owner: state.pathParameters['owner']!,
        repo: state.pathParameters['repo']!,
      );

  DetailRoute get _self => this as DetailRoute;

  @override
  String get location => GoRouteData.$location(
        '/detail/${Uri.encodeComponent(_self.owner)}/${Uri.encodeComponent(_self.repo)}',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
