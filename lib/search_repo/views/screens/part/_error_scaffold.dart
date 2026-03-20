part of '../repo_detail_screen.dart';

class _ErrorScaffold extends StatelessWidget {
  const _ErrorScaffold({
    required this.owner,
    required this.repo,
    required this.exception,
  });

  final String owner;
  final String repo;
  final GithubRepoApiException exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$owner/$repo')),
      body: Center(child: Text(exception.localizedMessage(context))),
    );
  }
}
