import 'package:json_annotation/json_annotation.dart';
part 'search_api_struct.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SearchApiModelStruct {
  SearchApiModelStruct(this.total_count, this.items);

  int total_count;
  List<Item> items;

  factory SearchApiModelStruct.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelStructFromJson(json);
  Map<String, dynamic> toJson() => _$SearchApiModelStructToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Item {
  Item(this.name, this.stargazersCount, this.watchersCount, this.language,
      this.forksCount, this.openIssuesCount, this.owner);
  String name;
  int stargazersCount;
  int watchersCount;
  String? language;
  int forksCount;
  int openIssuesCount;
  Owner owner;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Owner {
  Owner(this.avatarUrl);
  String avatarUrl;
  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}