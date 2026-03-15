---
name: future-provider-pattern
description: loading / loaded / error の3パターンで十分な場合は FutureProvider を使う。Initial が不要な「1回 fetch して表示」系に適用。Flutter Riverpod の API 連携、AsyncValue、FutureProvider の選択時に参照する。
---

# FutureProvider パターン

## 適用条件

**loading・loaded・error の3パターンで十分な場合は FutureProvider を使う。**

- Initial 状態が不要な「1回 fetch して表示」系
- Notifier + sealed class（Initial/Loading/Success/Error）は冗長になりがち

## 実装例

### Provider

```dart
final repoDetailProvider =
    FutureProvider.autoDispose.family<Item, ({String owner, String repo})>(
  (ref, arg) async {
    final api = ref.read(githubRepoApiProvider);
    final result = await api.getRepository(owner: arg.owner, repo: arg.repo);
    switch (result) {
      case Success(:final data):
        ref.read(repoItemsProvider.notifier).updateItem(arg.owner, arg.repo, data);
        return data;
      case Failure(:final exception):
        throw exception;
    }
  },
);
```

### 画面（AsyncValue.when）

```dart
final asyncDetail = ref.watch(repoDetailProvider((owner: owner, repo: repo)));

return asyncDetail.when(
  loading: () => _LoadingScaffold(...),
  data: (item) => _Content(item: item, ...),
  error: (e, _) => _ErrorScaffold(exception: e as GithubRepoApiException, ...),
);
```

## Notifier を使う場合

- 検索のように「ユーザー操作でトリガー」「Initial で何も表示しない」場合は Notifier + sealed が適切
- 詳細のように「画面表示と同時に fetch」「loading → data/error のみ」の場合は FutureProvider が適切
