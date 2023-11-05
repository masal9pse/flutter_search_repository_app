import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_api_model.freezed.dart';
part 'search_api_model.g.dart';

@freezed
class SearchApiModel with _$SearchApiModel {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory SearchApiModel({
    @Default(0) int totalCount,
    @Default(<Item>[]) List<Item> items,
  }) = _SearchApiModel;

  static const mockData = SearchApiModel(
    totalCount: 8,
    items: [
      Item(
        name: "Item1",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://avatars.githubusercontent.com/u/84199788?v=4",
        ),
      ),
      Item(
        name: "Item2",
        stargazersCount: 10,
        watchersCount: 5,
        language: "python",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar2.png",
        ),
      ),
      Item(
        name: "Item3",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar3.png",
        ),
      ),
      Item(
        name: "Item4",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar4.png",
        ),
      ),
      Item(
        name: "Item5",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar5.png",
        ),
      ),
      Item(
        name: "Item6",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar5.png",
        ),
      ),
      Item(
        name: "Item7",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar6.png",
        ),
      ),
      Item(
        name: "Item8",
        stargazersCount: 10,
        watchersCount: 5,
        language: "js",
        forksCount: 3,
        openIssuesCount: 2,
        owner: Owner(
          avatarUrl: "https://example.com/avatar7.png",
        ),
      ),
    ],
  );

  factory SearchApiModel.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelFromJson(json);
}

@freezed
class Item with _$Item {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Item({
    @Default('') String name,
    @Default(0) int stargazersCount,
    @Default(0) int watchersCount,
    @Default('') String language,
    @Default(0) int forksCount,
    @Default(0) int openIssuesCount,
    @Default(Owner()) Owner owner,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Owner with _$Owner {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Owner({
    @Default('') String avatarUrl,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
