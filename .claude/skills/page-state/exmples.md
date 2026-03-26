```dart
sealed class RepoSearchState {
  const RepoSearchState();

  // factoryからは内部のプライベートコンストラクタを呼ぶ
  const factory RepoSearchState.initial() = RepoSearchInitial._;
  const factory RepoSearchState.loading() = RepoSearchLoading._;
  const factory RepoSearchState.success(List<String> items) = RepoSearchSuccess._;
  const factory RepoSearchState.error(Exception exception) = RepoSearchError._;
}

// 1. クラス名は公開（外から switch で使える）
final class RepoSearchInitial extends RepoSearchState {
  // 2. コンストラクタをプライベート化（外から RepoSearchInitial() はできない）
  const RepoSearchInitial._(); 
}

final class RepoSearchLoading extends RepoSearchState {
  const RepoSearchLoading._();
}

final class RepoSearchSuccess extends RepoSearchState {
  const RepoSearchSuccess._(this.items);
  final List<String> items;
}

final class RepoSearchError extends RepoSearchState {
  const RepoSearchError._(this.exception);
  final Exception exception;
}

```