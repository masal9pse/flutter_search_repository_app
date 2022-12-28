enum PageInfoEnum {
  top(title: 'GitHub検索App', route: '/'),
  show(title: '詳細ページ', route: '/show');

  const PageInfoEnum({required this.title, required this.route});
  final String title;
  final String route;
}
