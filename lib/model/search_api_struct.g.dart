// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_struct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchApiModelStruct _$SearchApiModelStructFromJson(Map<String, dynamic> json) {
  return SearchApiModelStruct(
    json['total_count'] as int,
    (json['items'] as List<dynamic>)
        .map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SearchApiModelStructToJson(
        SearchApiModelStruct instance) =>
    <String, dynamic>{
      'total_count': instance.total_count,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    json['name'] as String,
    json['language'] as String,
    json['stargazers_count'] as String,
    json['watchers_count'] as String,
    json['forks_count'] as String,
    json['open_issues_count'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'language': instance.language,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'forks_count': instance.forksCount,
      'open_issues_count': instance.openIssuesCount,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'avatar_url': instance.avatarUrl,
    };
