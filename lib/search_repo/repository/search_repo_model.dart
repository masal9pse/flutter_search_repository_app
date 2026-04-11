import 'package:json_annotation/json_annotation.dart';

part 'search_repo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RepoList {
  const RepoList({
    this.totalCount = 0,
    this.items = const [],
  });

  factory RepoList.fromJson(Map<String, dynamic> json) =>
      _$RepoListFromJson(json);

  @JsonKey(defaultValue: 0)
  final int totalCount;
  @JsonKey(defaultValue: [])
  final List<Repo> items;
  Map<String, dynamic> toJson() => _$RepoListToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Repo {
  const Repo({
    required this.owner,
    this.id,
    this.name = '',
    this.stargazersCount = 0,
    this.watchersCount = 0,
    this.language = '',
    this.forksCount = 0,
    this.openIssuesCount = 0,
  });

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);

  final int? id;
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
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Owner {
  const Owner({
    this.login = '',
    this.avatarUrl = '',
  });

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);

  @JsonKey(defaultValue: '')
  final String login;
  @JsonKey(defaultValue: '')
  final String avatarUrl;
  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
