import 'package:gql/ast.dart';

class Variables$Query$Repositories {
  factory Variables$Query$Repositories({int? last}) =>
      Variables$Query$Repositories._({
        if (last != null) r'last': last,
      });

  Variables$Query$Repositories._(this._$data);

  factory Variables$Query$Repositories.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('last')) {
      final l$last = data['last'];
      result$data['last'] = (l$last as int);
    }
    return Variables$Query$Repositories._(result$data);
  }

  Map<String, dynamic> _$data;

  int? get last => (_$data['last'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('last')) {
      final l$last = last;
      result$data['last'] = (l$last as int);
    }
    return result$data;
  }

  CopyWith$Variables$Query$Repositories<Variables$Query$Repositories>
      get copyWith => CopyWith$Variables$Query$Repositories(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Repositories ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$last = last;
    final lOther$last = other.last;
    if (_$data.containsKey('last') != other._$data.containsKey('last')) {
      return false;
    }
    if (l$last != lOther$last) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$last = last;
    return Object.hashAll([_$data.containsKey('last') ? l$last : const {}]);
  }
}

abstract class CopyWith$Variables$Query$Repositories<TRes> {
  factory CopyWith$Variables$Query$Repositories(
    Variables$Query$Repositories instance,
    TRes Function(Variables$Query$Repositories) then,
  ) = _CopyWithImpl$Variables$Query$Repositories;

  factory CopyWith$Variables$Query$Repositories.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Repositories;

  TRes call({int? last});
}

class _CopyWithImpl$Variables$Query$Repositories<TRes>
    implements CopyWith$Variables$Query$Repositories<TRes> {
  _CopyWithImpl$Variables$Query$Repositories(
    this._instance,
    this._then,
  );

  final Variables$Query$Repositories _instance;

  final TRes Function(Variables$Query$Repositories) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? last = _undefined}) =>
      _then(Variables$Query$Repositories._({
        ..._instance._$data,
        if (last != _undefined && last != null) 'last': (last as int),
      }));
}

class _CopyWithStubImpl$Variables$Query$Repositories<TRes>
    implements CopyWith$Variables$Query$Repositories<TRes> {
  _CopyWithStubImpl$Variables$Query$Repositories(this._res);

  TRes _res;

  call({int? last}) => _res;
}

class Query$Repositories {
  Query$Repositories({
    required this.viewer,
    this.$__typename = 'Query',
  });

  factory Query$Repositories.fromJson(Map<String, dynamic> json) {
    final l$viewer = json['viewer'];
    final l$$__typename = json['__typename'];
    return Query$Repositories(
      viewer: Query$Repositories$viewer.fromJson(
          (l$viewer as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Repositories$viewer viewer;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$viewer = viewer;
    _resultData['viewer'] = l$viewer.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$viewer = viewer;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$viewer,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Repositories || runtimeType != other.runtimeType) {
      return false;
    }
    final l$viewer = viewer;
    final lOther$viewer = other.viewer;
    if (l$viewer != lOther$viewer) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Repositories on Query$Repositories {
  CopyWith$Query$Repositories<Query$Repositories> get copyWith =>
      CopyWith$Query$Repositories(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Repositories<TRes> {
  factory CopyWith$Query$Repositories(
    Query$Repositories instance,
    TRes Function(Query$Repositories) then,
  ) = _CopyWithImpl$Query$Repositories;

  factory CopyWith$Query$Repositories.stub(TRes res) =
      _CopyWithStubImpl$Query$Repositories;

  TRes call({
    Query$Repositories$viewer? viewer,
    String? $__typename,
  });
  CopyWith$Query$Repositories$viewer<TRes> get viewer;
}

class _CopyWithImpl$Query$Repositories<TRes>
    implements CopyWith$Query$Repositories<TRes> {
  _CopyWithImpl$Query$Repositories(
    this._instance,
    this._then,
  );

  final Query$Repositories _instance;

  final TRes Function(Query$Repositories) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? viewer = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Repositories(
        viewer: viewer == _undefined || viewer == null
            ? _instance.viewer
            : (viewer as Query$Repositories$viewer),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$Repositories$viewer<TRes> get viewer {
    final local$viewer = _instance.viewer;
    return CopyWith$Query$Repositories$viewer(
        local$viewer, (e) => call(viewer: e));
  }
}

class _CopyWithStubImpl$Query$Repositories<TRes>
    implements CopyWith$Query$Repositories<TRes> {
  _CopyWithStubImpl$Query$Repositories(this._res);

  TRes _res;

  call({
    Query$Repositories$viewer? viewer,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$Repositories$viewer<TRes> get viewer =>
      CopyWith$Query$Repositories$viewer.stub(_res);
}

const documentNodeQueryRepositories = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Repositories'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'last')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: IntValueNode(value: '10')),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'viewer'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'repositories'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'last'),
                value: VariableNode(name: NameNode(value: 'last')),
              ),
              ArgumentNode(
                name: NameNode(value: 'orderBy'),
                value: ObjectValueNode(fields: [
                  ObjectFieldNode(
                    name: NameNode(value: 'field'),
                    value: EnumValueNode(name: NameNode(value: 'UPDATED_AT')),
                  ),
                  ObjectFieldNode(
                    name: NameNode(value: 'direction'),
                    value: EnumValueNode(name: NameNode(value: 'DESC')),
                  ),
                ]),
              ),
              ArgumentNode(
                name: NameNode(value: 'privacy'),
                value: EnumValueNode(name: NameNode(value: 'PUBLIC')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: 'nodes'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: SelectionSetNode(selections: [
                  FieldNode(
                    name: NameNode(value: 'id'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'name'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'description'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'url'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: 'updatedAt'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                  FieldNode(
                    name: NameNode(value: '__typename'),
                    alias: null,
                    arguments: [],
                    directives: [],
                    selectionSet: null,
                  ),
                ]),
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Query$Repositories$viewer {
  Query$Repositories$viewer({
    required this.repositories,
    this.$__typename = 'User',
  });

  factory Query$Repositories$viewer.fromJson(Map<String, dynamic> json) {
    final l$repositories = json['repositories'];
    final l$$__typename = json['__typename'];
    return Query$Repositories$viewer(
      repositories: Query$Repositories$viewer$repositories.fromJson(
          (l$repositories as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Repositories$viewer$repositories repositories;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$repositories = repositories;
    _resultData['repositories'] = l$repositories.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$repositories = repositories;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$repositories,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Repositories$viewer ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$repositories = repositories;
    final lOther$repositories = other.repositories;
    if (l$repositories != lOther$repositories) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Repositories$viewer
    on Query$Repositories$viewer {
  CopyWith$Query$Repositories$viewer<Query$Repositories$viewer> get copyWith =>
      CopyWith$Query$Repositories$viewer(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Repositories$viewer<TRes> {
  factory CopyWith$Query$Repositories$viewer(
    Query$Repositories$viewer instance,
    TRes Function(Query$Repositories$viewer) then,
  ) = _CopyWithImpl$Query$Repositories$viewer;

  factory CopyWith$Query$Repositories$viewer.stub(TRes res) =
      _CopyWithStubImpl$Query$Repositories$viewer;

  TRes call({
    Query$Repositories$viewer$repositories? repositories,
    String? $__typename,
  });
  CopyWith$Query$Repositories$viewer$repositories<TRes> get repositories;
}

class _CopyWithImpl$Query$Repositories$viewer<TRes>
    implements CopyWith$Query$Repositories$viewer<TRes> {
  _CopyWithImpl$Query$Repositories$viewer(
    this._instance,
    this._then,
  );

  final Query$Repositories$viewer _instance;

  final TRes Function(Query$Repositories$viewer) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? repositories = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Repositories$viewer(
        repositories: repositories == _undefined || repositories == null
            ? _instance.repositories
            : (repositories as Query$Repositories$viewer$repositories),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$Repositories$viewer$repositories<TRes> get repositories {
    final local$repositories = _instance.repositories;
    return CopyWith$Query$Repositories$viewer$repositories(
        local$repositories, (e) => call(repositories: e));
  }
}

class _CopyWithStubImpl$Query$Repositories$viewer<TRes>
    implements CopyWith$Query$Repositories$viewer<TRes> {
  _CopyWithStubImpl$Query$Repositories$viewer(this._res);

  TRes _res;

  call({
    Query$Repositories$viewer$repositories? repositories,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$Repositories$viewer$repositories<TRes> get repositories =>
      CopyWith$Query$Repositories$viewer$repositories.stub(_res);
}

class Query$Repositories$viewer$repositories {
  Query$Repositories$viewer$repositories({
    this.nodes,
    this.$__typename = 'RepositoryConnection',
  });

  factory Query$Repositories$viewer$repositories.fromJson(
      Map<String, dynamic> json) {
    final l$nodes = json['nodes'];
    final l$$__typename = json['__typename'];
    return Query$Repositories$viewer$repositories(
      nodes: (l$nodes as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$Repositories$viewer$repositories$nodes.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Query$Repositories$viewer$repositories$nodes?>? nodes;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$nodes = nodes;
    _resultData['nodes'] = l$nodes?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$nodes = nodes;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$nodes == null ? null : Object.hashAll(l$nodes.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Repositories$viewer$repositories ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$nodes = nodes;
    final lOther$nodes = other.nodes;
    if (l$nodes != null && lOther$nodes != null) {
      if (l$nodes.length != lOther$nodes.length) {
        return false;
      }
      for (int i = 0; i < l$nodes.length; i++) {
        final l$nodes$entry = l$nodes[i];
        final lOther$nodes$entry = lOther$nodes[i];
        if (l$nodes$entry != lOther$nodes$entry) {
          return false;
        }
      }
    } else if (l$nodes != lOther$nodes) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Repositories$viewer$repositories
    on Query$Repositories$viewer$repositories {
  CopyWith$Query$Repositories$viewer$repositories<
          Query$Repositories$viewer$repositories>
      get copyWith => CopyWith$Query$Repositories$viewer$repositories(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Repositories$viewer$repositories<TRes> {
  factory CopyWith$Query$Repositories$viewer$repositories(
    Query$Repositories$viewer$repositories instance,
    TRes Function(Query$Repositories$viewer$repositories) then,
  ) = _CopyWithImpl$Query$Repositories$viewer$repositories;

  factory CopyWith$Query$Repositories$viewer$repositories.stub(TRes res) =
      _CopyWithStubImpl$Query$Repositories$viewer$repositories;

  TRes call({
    List<Query$Repositories$viewer$repositories$nodes?>? nodes,
    String? $__typename,
  });
  TRes nodes(
      Iterable<Query$Repositories$viewer$repositories$nodes?>? Function(
              Iterable<
                  CopyWith$Query$Repositories$viewer$repositories$nodes<
                      Query$Repositories$viewer$repositories$nodes>?>?)
          _fn);
}

class _CopyWithImpl$Query$Repositories$viewer$repositories<TRes>
    implements CopyWith$Query$Repositories$viewer$repositories<TRes> {
  _CopyWithImpl$Query$Repositories$viewer$repositories(
    this._instance,
    this._then,
  );

  final Query$Repositories$viewer$repositories _instance;

  final TRes Function(Query$Repositories$viewer$repositories) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? nodes = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Repositories$viewer$repositories(
        nodes: nodes == _undefined
            ? _instance.nodes
            : (nodes as List<Query$Repositories$viewer$repositories$nodes?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes nodes(
          Iterable<Query$Repositories$viewer$repositories$nodes?>? Function(
                  Iterable<
                      CopyWith$Query$Repositories$viewer$repositories$nodes<
                          Query$Repositories$viewer$repositories$nodes>?>?)
              _fn) =>
      call(
          nodes: _fn(_instance.nodes?.map((e) => e == null
              ? null
              : CopyWith$Query$Repositories$viewer$repositories$nodes(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$Repositories$viewer$repositories<TRes>
    implements CopyWith$Query$Repositories$viewer$repositories<TRes> {
  _CopyWithStubImpl$Query$Repositories$viewer$repositories(this._res);

  TRes _res;

  call({
    List<Query$Repositories$viewer$repositories$nodes?>? nodes,
    String? $__typename,
  }) =>
      _res;

  nodes(_fn) => _res;
}

class Query$Repositories$viewer$repositories$nodes {
  Query$Repositories$viewer$repositories$nodes({
    required this.id,
    required this.name,
    this.description,
    required this.url,
    required this.updatedAt,
    this.$__typename = 'Repository',
  });

  factory Query$Repositories$viewer$repositories$nodes.fromJson(
      Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$description = json['description'];
    final l$url = json['url'];
    final l$updatedAt = json['updatedAt'];
    final l$$__typename = json['__typename'];
    return Query$Repositories$viewer$repositories$nodes(
      id: (l$id as String),
      name: (l$name as String),
      description: (l$description as String?),
      url: (l$url as String),
      updatedAt: (l$updatedAt as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String? description;

  final String url;

  final String updatedAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$url = url;
    _resultData['url'] = l$url;
    final l$updatedAt = updatedAt;
    _resultData['updatedAt'] = l$updatedAt;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$description = description;
    final l$url = url;
    final l$updatedAt = updatedAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$description,
      l$url,
      l$updatedAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Repositories$viewer$repositories$nodes ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$url = url;
    final lOther$url = other.url;
    if (l$url != lOther$url) {
      return false;
    }
    final l$updatedAt = updatedAt;
    final lOther$updatedAt = other.updatedAt;
    if (l$updatedAt != lOther$updatedAt) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Repositories$viewer$repositories$nodes
    on Query$Repositories$viewer$repositories$nodes {
  CopyWith$Query$Repositories$viewer$repositories$nodes<
          Query$Repositories$viewer$repositories$nodes>
      get copyWith => CopyWith$Query$Repositories$viewer$repositories$nodes(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$Repositories$viewer$repositories$nodes<TRes> {
  factory CopyWith$Query$Repositories$viewer$repositories$nodes(
    Query$Repositories$viewer$repositories$nodes instance,
    TRes Function(Query$Repositories$viewer$repositories$nodes) then,
  ) = _CopyWithImpl$Query$Repositories$viewer$repositories$nodes;

  factory CopyWith$Query$Repositories$viewer$repositories$nodes.stub(TRes res) =
      _CopyWithStubImpl$Query$Repositories$viewer$repositories$nodes;

  TRes call({
    String? id,
    String? name,
    String? description,
    String? url,
    String? updatedAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Repositories$viewer$repositories$nodes<TRes>
    implements CopyWith$Query$Repositories$viewer$repositories$nodes<TRes> {
  _CopyWithImpl$Query$Repositories$viewer$repositories$nodes(
    this._instance,
    this._then,
  );

  final Query$Repositories$viewer$repositories$nodes _instance;

  final TRes Function(Query$Repositories$viewer$repositories$nodes) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? description = _undefined,
    Object? url = _undefined,
    Object? updatedAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Repositories$viewer$repositories$nodes(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        description: description == _undefined
            ? _instance.description
            : (description as String?),
        url: url == _undefined || url == null ? _instance.url : (url as String),
        updatedAt: updatedAt == _undefined || updatedAt == null
            ? _instance.updatedAt
            : (updatedAt as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Repositories$viewer$repositories$nodes<TRes>
    implements CopyWith$Query$Repositories$viewer$repositories$nodes<TRes> {
  _CopyWithStubImpl$Query$Repositories$viewer$repositories$nodes(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? description,
    String? url,
    String? updatedAt,
    String? $__typename,
  }) =>
      _res;
}
