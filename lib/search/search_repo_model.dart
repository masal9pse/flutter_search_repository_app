import 'package:json_annotation/json_annotation.dart';

part 'search_repo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchApiModel {
  const SearchApiModel({
    this.totalCount = 0,
    this.items = const [],
  });

  factory SearchApiModel.fromJson(Map<String, dynamic> json) =>
      _$SearchApiModelFromJson(json);

  @JsonKey(defaultValue: 0)
  final int totalCount;
  @JsonKey(defaultValue: [])
  final List<Item> items;
  Map<String, dynamic> toJson() => _$SearchApiModelToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Item {
  const Item({
    required this.owner,
    this.name = '',
    this.stargazersCount = 0,
    this.watchersCount = 0,
    this.language = '',
    this.forksCount = 0,
    this.openIssuesCount = 0,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: 0)
  final int stargazersCount;
  @JsonKey(defaultValue: 0)
  final int watchersCount;
  @JsonKey(defaultValue: '')
  final String language;
  @JsonKey(defaultValue: 0)
  final int forksCount;
  @JsonKey(defaultValue: 0)
  final int openIssuesCount;
  final Owner owner;
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Owner {
  const Owner({
    this.avatarUrl = '',
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  @JsonKey(defaultValue: '')
  final String avatarUrl;
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
