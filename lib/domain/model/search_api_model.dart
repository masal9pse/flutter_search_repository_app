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
