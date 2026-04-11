// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepoList _$RepoListFromJson(Map<String, dynamic> json) => RepoList(
      totalCount: (json['total_count'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Repo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RepoListToJson(RepoList instance) => <String, dynamic>{
      'total_count': instance.totalCount,
      'items': instance.items,
    };

Repo _$RepoFromJson(Map<String, dynamic> json) => Repo(
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      stargazersCount: (json['stargazers_count'] as num?)?.toInt() ?? 0,
      watchersCount: (json['watchers_count'] as num?)?.toInt() ?? 0,
      language: json['language'] as String? ?? '',
      forksCount: (json['forks_count'] as num?)?.toInt() ?? 0,
      openIssuesCount: (json['open_issues_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
      'owner': instance.owner,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      login: json['login'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String? ?? '',
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
    };
