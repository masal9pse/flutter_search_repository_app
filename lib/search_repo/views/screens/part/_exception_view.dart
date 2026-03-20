part of '../repo_search_screen.dart';

/// エラー発生時に表示するWidget
///
/// こういうのもVRTでテストしたい
class _ExceptionView extends ConsumerWidget {
  const _ExceptionView({required this.exception});

  final GithubRepoApiException exception;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (exception) {
      case NetworkGithubRepoApiException() ||
            CanceledGithubRepoApiException() ||
            BadCertificateGithubRepoApiException() ||
            InvalidResponseGithubRepoApiException() ||
            UnknownGithubRepoApiException() ||
            ServerGithubRepoApiException() ||
            NotFoundGithubRepoApiException() ||
            UnauthorizedGithubRepoApiException() ||
            RateLimitGithubRepoApiException() ||
            HttpGithubRepoApiException():
        return Column(
          children: [
            Text(exception.localizedMessage(context)),
            const Text('widget分けるイメージ1'),
          ],
        );
      case TimeoutGithubRepoApiException():
        return Column(
          children: [
            Text(exception.localizedMessage(context)),
            const Text('widget分けるイメージ2'),
          ],
        );
    }
  }
}
