import 'package:freezed_annotation/freezed_annotation.dart';
part 'search_api_struct.freezed.dart';
part 'search_api_struct.g.dart';

@freezed
class SearchApiModelStruct with _$SearchApiModelStruct {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory SearchApiModelStruct({
    required int totalCount,
    required List<Item> items,
  }) = _SearchApiModelStruct;

  factory SearchApiModelStruct.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelStructFromJson(json);
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
