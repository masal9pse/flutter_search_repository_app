part of '../repo_detail_screen.dart';

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold({required this.owner, required this.repo});

  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$owner/$repo')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
