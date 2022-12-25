// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_api_struct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchApiModelStruct _$SearchApiModelStructFromJson(Map<String, dynamic> json) {
  return _SearchApiModelStruct.fromJson(json);
}

/// @nodoc
mixin _$SearchApiModelStruct {
  int get totalCount => throw _privateConstructorUsedError;
  List<Item> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchApiModelStructCopyWith<SearchApiModelStruct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchApiModelStructCopyWith<$Res> {
  factory $SearchApiModelStructCopyWith(SearchApiModelStruct value,
          $Res Function(SearchApiModelStruct) then) =
      _$SearchApiModelStructCopyWithImpl<$Res, SearchApiModelStruct>;
  @useResult
  $Res call({int totalCount, List<Item> items});
}

/// @nodoc
class _$SearchApiModelStructCopyWithImpl<$Res,
        $Val extends SearchApiModelStruct>
    implements $SearchApiModelStructCopyWith<$Res> {
  _$SearchApiModelStructCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchApiModelStructCopyWith<$Res>
    implements $SearchApiModelStructCopyWith<$Res> {
  factory _$$_SearchApiModelStructCopyWith(_$_SearchApiModelStruct value,
          $Res Function(_$_SearchApiModelStruct) then) =
      __$$_SearchApiModelStructCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalCount, List<Item> items});
}

/// @nodoc
class __$$_SearchApiModelStructCopyWithImpl<$Res>
    extends _$SearchApiModelStructCopyWithImpl<$Res, _$_SearchApiModelStruct>
    implements _$$_SearchApiModelStructCopyWith<$Res> {
  __$$_SearchApiModelStructCopyWithImpl(_$_SearchApiModelStruct _value,
      $Res Function(_$_SearchApiModelStruct) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCount = null,
    Object? items = null,
  }) {
    return _then(_$_SearchApiModelStruct(
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Item>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SearchApiModelStruct implements _SearchApiModelStruct {
  const _$_SearchApiModelStruct(
      {required this.totalCount, required final List<Item> items})
      : _items = items;

  factory _$_SearchApiModelStruct.fromJson(Map<String, dynamic> json) =>
      _$$_SearchApiModelStructFromJson(json);

  @override
  final int totalCount;
  final List<Item> _items;
  @override
  List<Item> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'SearchApiModelStruct(totalCount: $totalCount, items: $items)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchApiModelStruct &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalCount, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchApiModelStructCopyWith<_$_SearchApiModelStruct> get copyWith =>
      __$$_SearchApiModelStructCopyWithImpl<_$_SearchApiModelStruct>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SearchApiModelStructToJson(
      this,
    );
  }
}

abstract class _SearchApiModelStruct implements SearchApiModelStruct {
  const factory _SearchApiModelStruct(
      {required final int totalCount,
      required final List<Item> items}) = _$_SearchApiModelStruct;

  factory _SearchApiModelStruct.fromJson(Map<String, dynamic> json) =
      _$_SearchApiModelStruct.fromJson;

  @override
  int get totalCount;
  @override
  List<Item> get items;
  @override
  @JsonKey(ignore: true)
  _$$_SearchApiModelStructCopyWith<_$_SearchApiModelStruct> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  String get name => throw _privateConstructorUsedError;
  int? get stargazersCount => throw _privateConstructorUsedError;
  int? get watchersCount => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  int? get forksCount => throw _privateConstructorUsedError;
  int? get openIssuesCount => throw _privateConstructorUsedError;
  Owner get owner => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemCopyWith<Item> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
  @useResult
  $Res call(
      {String name,
      int? stargazersCount,
      int? watchersCount,
      String? language,
      int? forksCount,
      int? openIssuesCount,
      Owner owner});

  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
    Object? owner = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stargazersCount: freezed == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      watchersCount: freezed == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: freezed == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int?,
      openIssuesCount: freezed == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OwnerCopyWith<$Res> get owner {
    return $OwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ItemCopyWith<$Res> implements $ItemCopyWith<$Res> {
  factory _$$_ItemCopyWith(_$_Item value, $Res Function(_$_Item) then) =
      __$$_ItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      int? stargazersCount,
      int? watchersCount,
      String? language,
      int? forksCount,
      int? openIssuesCount,
      Owner owner});

  @override
  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class __$$_ItemCopyWithImpl<$Res> extends _$ItemCopyWithImpl<$Res, _$_Item>
    implements _$$_ItemCopyWith<$Res> {
  __$$_ItemCopyWithImpl(_$_Item _value, $Res Function(_$_Item) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? stargazersCount = freezed,
    Object? watchersCount = freezed,
    Object? language = freezed,
    Object? forksCount = freezed,
    Object? openIssuesCount = freezed,
    Object? owner = null,
  }) {
    return _then(_$_Item(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      stargazersCount: freezed == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      watchersCount: freezed == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: freezed == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int?,
      openIssuesCount: freezed == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Item implements _Item {
  const _$_Item(
      {required this.name,
      this.stargazersCount,
      this.watchersCount,
      this.language,
      this.forksCount,
      this.openIssuesCount,
      required this.owner});

  factory _$_Item.fromJson(Map<String, dynamic> json) => _$$_ItemFromJson(json);

  @override
  final String name;
  @override
  final int? stargazersCount;
  @override
  final int? watchersCount;
  @override
  final String? language;
  @override
  final int? forksCount;
  @override
  final int? openIssuesCount;
  @override
  final Owner owner;

  @override
  String toString() {
    return 'Item(name: $name, stargazersCount: $stargazersCount, watchersCount: $watchersCount, language: $language, forksCount: $forksCount, openIssuesCount: $openIssuesCount, owner: $owner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Item &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.stargazersCount, stargazersCount) ||
                other.stargazersCount == stargazersCount) &&
            (identical(other.watchersCount, watchersCount) ||
                other.watchersCount == watchersCount) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.forksCount, forksCount) ||
                other.forksCount == forksCount) &&
            (identical(other.openIssuesCount, openIssuesCount) ||
                other.openIssuesCount == openIssuesCount) &&
            (identical(other.owner, owner) || other.owner == owner));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, stargazersCount,
      watchersCount, language, forksCount, openIssuesCount, owner);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemCopyWith<_$_Item> get copyWith =>
      __$$_ItemCopyWithImpl<_$_Item>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item(
      {required final String name,
      final int? stargazersCount,
      final int? watchersCount,
      final String? language,
      final int? forksCount,
      final int? openIssuesCount,
      required final Owner owner}) = _$_Item;

  factory _Item.fromJson(Map<String, dynamic> json) = _$_Item.fromJson;

  @override
  String get name;
  @override
  int? get stargazersCount;
  @override
  int? get watchersCount;
  @override
  String? get language;
  @override
  int? get forksCount;
  @override
  int? get openIssuesCount;
  @override
  Owner get owner;
  @override
  @JsonKey(ignore: true)
  _$$_ItemCopyWith<_$_Item> get copyWith => throw _privateConstructorUsedError;
}

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return _Owner.fromJson(json);
}

/// @nodoc
mixin _$Owner {
  String get avatarUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OwnerCopyWith<Owner> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OwnerCopyWith<$Res> {
  factory $OwnerCopyWith(Owner value, $Res Function(Owner) then) =
      _$OwnerCopyWithImpl<$Res, Owner>;
  @useResult
  $Res call({String avatarUrl});
}

/// @nodoc
class _$OwnerCopyWithImpl<$Res, $Val extends Owner>
    implements $OwnerCopyWith<$Res> {
  _$OwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatarUrl = null,
  }) {
    return _then(_value.copyWith(
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OwnerCopyWith<$Res> implements $OwnerCopyWith<$Res> {
  factory _$$_OwnerCopyWith(_$_Owner value, $Res Function(_$_Owner) then) =
      __$$_OwnerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String avatarUrl});
}

/// @nodoc
class __$$_OwnerCopyWithImpl<$Res> extends _$OwnerCopyWithImpl<$Res, _$_Owner>
    implements _$$_OwnerCopyWith<$Res> {
  __$$_OwnerCopyWithImpl(_$_Owner _value, $Res Function(_$_Owner) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? avatarUrl = null,
  }) {
    return _then(_$_Owner(
      avatarUrl: null == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Owner implements _Owner {
  const _$_Owner({required this.avatarUrl});

  factory _$_Owner.fromJson(Map<String, dynamic> json) =>
      _$$_OwnerFromJson(json);

  @override
  final String avatarUrl;

  @override
  String toString() {
    return 'Owner(avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Owner &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, avatarUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OwnerCopyWith<_$_Owner> get copyWith =>
      __$$_OwnerCopyWithImpl<_$_Owner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OwnerToJson(
      this,
    );
  }
}

abstract class _Owner implements Owner {
  const factory _Owner({required final String avatarUrl}) = _$_Owner;

  factory _Owner.fromJson(Map<String, dynamic> json) = _$_Owner.fromJson;

  @override
  String get avatarUrl;
  @override
  @JsonKey(ignore: true)
  _$$_OwnerCopyWith<_$_Owner> get copyWith =>
      throw _privateConstructorUsedError;
}