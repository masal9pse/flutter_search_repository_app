import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_api_model.freezed.dart';
part 'search_api_model.g.dart';

@freezed
class SearchApiModel with _$SearchApiModel {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory SearchApiModel({
    required int totalCount,
    required List<Item> items,
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
    required int id,
    required String name,
    int? stargazersCount,
    int? watchersCount,
    String? language,
    int? forksCount,
    int? openIssuesCount,
    required Owner owner,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}

@freezed
class Owner with _$Owner{
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory Owner({
    required String avatarUrl,
  }) = _Owner;

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
