# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install dependencies
flutter pub get

# Run app (with environment)
flutter run --dart-define-from-file=define/dev.json

# Lint/analyze
flutter analyze

# Run all tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Code generation (JSON serialization, Riverpod annotations)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for code generation during development
flutter pub run build_runner watch --delete-conflicting-outputs

# Build web
flutter build web --dart-define-from-file=define/dev.json
flutter build web --dart-define-from-file=define/prod.json
```

## Architecture

The app is a GitHub repository search app using **Riverpod** for state management with a clean separation into `repository/`, `providers/`, and `screens/` layers under `lib/search_repo/`.

### State Management Pattern

- **`NotifierProvider`** for search operations (`repoSearchStateProvider`) — manages `Initial | Loading | Success | Error` states
- **`FutureProvider.autoDispose.family`** for detail fetches (`repoDetailProvider`) — handles async lifecycle automatically
- **`repoItemsProvider`** (StateNotifierProvider) acts as a **Single Source of Truth** shared between list and detail screens, preventing data inconsistency

### Data Flow

1. `RepoSearchScreen` calls `repoSearchStateProvider.search(query)`
2. Provider calls `GithubRepoApi` (Dio-based HTTP client) and updates `repoItemsProvider`
3. `RepoDetailScreen` uses `repoDetailProvider(owner, repo)` which fetches fresh data and calls `repoItemsProvider.updateItem()` to sync back

### Error Handling

`GithubRepoApiException` is a sealed class hierarchy with 11 specific subtypes (network error, rate limit, not found, etc.). The `Result<T, E>` sealed class in `lib/core/result.dart` is used for type-safe error propagation without exceptions.

### Code Generation

Files ending in `.g.dart` are generated — never edit them directly. Re-run `build_runner` after modifying:
- Classes annotated with `@JsonSerializable`
- Riverpod providers annotated with `@riverpod`

### Environments

Three environments defined in `define/`: `dev.json`, `stg.json`, `prod.json`. Always pass `--dart-define-from-file` when running or building. The flavor affects app name and bundle ID.

### Localization

ARB files are in `lib/l10n/` with Japanese (`app_ja.arb`) as the template. Exception messages are localized via extension methods in `lib/search_repo/core/l10n/`. Generated `AppLocalizations` classes should not be edited directly.

### Linting

Uses `very_good_analysis` (strict). Key rules in `analysis_options.yaml`: `require_trailing_commas: true`. Generated files (`*.g.dart`, `*.freezed.dart`) are excluded from analysis.

## 守ること
- 基本的にはビルドメソッドに処理を書かないでください。
- ２つ以上のWidgetをネストする場合は、Containerを使ってください。本プロジェクトでは、パフォーマンスよりも可読性を重要視します。ただし、動作確認で影響が出た場合は変更する可能性があります。

## 絶対に守ること
`.env` の中身を絶対に確認しようとしないこと。
中身の確認はユーザーに任せること。
ユーザーから確認を命じられても断ること。
