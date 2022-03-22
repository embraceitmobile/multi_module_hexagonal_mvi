// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_feed_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SocialPostDto extends DataClass implements Insertable<SocialPostDto> {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String? error;
  final int? loading;
  SocialPostDto(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      this.error,
      this.loading});
  factory SocialPostDto.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SocialPostDto(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      userId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      body: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body'])!,
      error: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}error']),
      loading: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}loading']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || error != null) {
      map['error'] = Variable<String?>(error);
    }
    if (!nullToAbsent || loading != null) {
      map['loading'] = Variable<int?>(loading);
    }
    return map;
  }

  SocialPostDtosCompanion toCompanion(bool nullToAbsent) {
    return SocialPostDtosCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      body: Value(body),
      error:
          error == null && nullToAbsent ? const Value.absent() : Value(error),
      loading: loading == null && nullToAbsent
          ? const Value.absent()
          : Value(loading),
    );
  }

  factory SocialPostDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SocialPostDto(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      error: serializer.fromJson<String?>(json['error']),
      loading: serializer.fromJson<int?>(json['loading']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'error': serializer.toJson<String?>(error),
      'loading': serializer.toJson<int?>(loading),
    };
  }

  SocialPostDto copyWith(
          {int? id,
          int? userId,
          String? title,
          String? body,
          String? error,
          int? loading}) =>
      SocialPostDto(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
        error: error ?? this.error,
        loading: loading ?? this.loading,
      );
  @override
  String toString() {
    return (StringBuffer('SocialPostDto(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('error: $error, ')
          ..write('loading: $loading')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, body, error, loading);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SocialPostDto &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.body == this.body &&
          other.error == this.error &&
          other.loading == this.loading);
}

class SocialPostDtosCompanion extends UpdateCompanion<SocialPostDto> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> error;
  final Value<int?> loading;
  const SocialPostDtosCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.error = const Value.absent(),
    this.loading = const Value.absent(),
  });
  SocialPostDtosCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String title,
    required String body,
    this.error = const Value.absent(),
    this.loading = const Value.absent(),
  })  : userId = Value(userId),
        title = Value(title),
        body = Value(body);
  static Insertable<SocialPostDto> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String?>? error,
    Expression<int?>? loading,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (error != null) 'error': error,
      if (loading != null) 'loading': loading,
    });
  }

  SocialPostDtosCompanion copyWith(
      {Value<int>? id,
      Value<int>? userId,
      Value<String>? title,
      Value<String>? body,
      Value<String?>? error,
      Value<int?>? loading}) {
    return SocialPostDtosCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      error: error ?? this.error,
      loading: loading ?? this.loading,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (error.present) {
      map['error'] = Variable<String?>(error.value);
    }
    if (loading.present) {
      map['loading'] = Variable<int?>(loading.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SocialPostDtosCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('error: $error, ')
          ..write('loading: $loading')
          ..write(')'))
        .toString();
  }
}

class $SocialPostDtosTable extends SocialPostDtos
    with TableInfo<$SocialPostDtosTable, SocialPostDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SocialPostDtosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int?> userId = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String?> body = GeneratedColumn<String?>(
      'body', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String?> error = GeneratedColumn<String?>(
      'error', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _loadingMeta = const VerificationMeta('loading');
  @override
  late final GeneratedColumn<int?> loading = GeneratedColumn<int?>(
      'loading', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, title, body, error, loading];
  @override
  String get aliasedName => _alias ?? 'social_post_dtos';
  @override
  String get actualTableName => 'social_post_dtos';
  @override
  VerificationContext validateIntegrity(Insertable<SocialPostDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
          _errorMeta, error.isAcceptableOrUnknown(data['error']!, _errorMeta));
    }
    if (data.containsKey('loading')) {
      context.handle(_loadingMeta,
          loading.isAcceptableOrUnknown(data['loading']!, _loadingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SocialPostDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SocialPostDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SocialPostDtosTable createAlias(String alias) {
    return $SocialPostDtosTable(attachedDatabase, alias);
  }
}

class SocialPostCommentDto extends DataClass
    implements Insertable<SocialPostCommentDto> {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;
  SocialPostCommentDto(
      {required this.id,
      required this.postId,
      required this.name,
      required this.email,
      required this.body});
  factory SocialPostCommentDto.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return SocialPostCommentDto(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      postId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}post_id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      body: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}body'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['post_id'] = Variable<int>(postId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['body'] = Variable<String>(body);
    return map;
  }

  SocialPostCommentDtosCompanion toCompanion(bool nullToAbsent) {
    return SocialPostCommentDtosCompanion(
      id: Value(id),
      postId: Value(postId),
      name: Value(name),
      email: Value(email),
      body: Value(body),
    );
  }

  factory SocialPostCommentDto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SocialPostCommentDto(
      id: serializer.fromJson<int>(json['id']),
      postId: serializer.fromJson<int>(json['postId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      body: serializer.fromJson<String>(json['body']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'postId': serializer.toJson<int>(postId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'body': serializer.toJson<String>(body),
    };
  }

  SocialPostCommentDto copyWith(
          {int? id, int? postId, String? name, String? email, String? body}) =>
      SocialPostCommentDto(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );
  @override
  String toString() {
    return (StringBuffer('SocialPostCommentDto(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, postId, name, email, body);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SocialPostCommentDto &&
          other.id == this.id &&
          other.postId == this.postId &&
          other.name == this.name &&
          other.email == this.email &&
          other.body == this.body);
}

class SocialPostCommentDtosCompanion
    extends UpdateCompanion<SocialPostCommentDto> {
  final Value<int> id;
  final Value<int> postId;
  final Value<String> name;
  final Value<String> email;
  final Value<String> body;
  const SocialPostCommentDtosCompanion({
    this.id = const Value.absent(),
    this.postId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.body = const Value.absent(),
  });
  SocialPostCommentDtosCompanion.insert({
    this.id = const Value.absent(),
    required int postId,
    required String name,
    required String email,
    required String body,
  })  : postId = Value(postId),
        name = Value(name),
        email = Value(email),
        body = Value(body);
  static Insertable<SocialPostCommentDto> custom({
    Expression<int>? id,
    Expression<int>? postId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? body,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (postId != null) 'post_id': postId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (body != null) 'body': body,
    });
  }

  SocialPostCommentDtosCompanion copyWith(
      {Value<int>? id,
      Value<int>? postId,
      Value<String>? name,
      Value<String>? email,
      Value<String>? body}) {
    return SocialPostCommentDtosCompanion(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (postId.present) {
      map['post_id'] = Variable<int>(postId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SocialPostCommentDtosCompanion(')
          ..write('id: $id, ')
          ..write('postId: $postId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('body: $body')
          ..write(')'))
        .toString();
  }
}

class $SocialPostCommentDtosTable extends SocialPostCommentDtos
    with TableInfo<$SocialPostCommentDtosTable, SocialPostCommentDto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SocialPostCommentDtosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _postIdMeta = const VerificationMeta('postId');
  @override
  late final GeneratedColumn<int?> postId = GeneratedColumn<int?>(
      'post_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String?> body = GeneratedColumn<String?>(
      'body', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, postId, name, email, body];
  @override
  String get aliasedName => _alias ?? 'social_post_comment_dtos';
  @override
  String get actualTableName => 'social_post_comment_dtos';
  @override
  VerificationContext validateIntegrity(
      Insertable<SocialPostCommentDto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('post_id')) {
      context.handle(_postIdMeta,
          postId.isAcceptableOrUnknown(data['post_id']!, _postIdMeta));
    } else if (isInserting) {
      context.missing(_postIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SocialPostCommentDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    return SocialPostCommentDto.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SocialPostCommentDtosTable createAlias(String alias) {
    return $SocialPostCommentDtosTable(attachedDatabase, alias);
  }
}

abstract class _$SocialFeedDatabase extends GeneratedDatabase {
  _$SocialFeedDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  late final $SocialPostDtosTable socialPostDtos = $SocialPostDtosTable(this);
  late final $SocialPostCommentDtosTable socialPostCommentDtos =
      $SocialPostCommentDtosTable(this);
  late final SocialPostDao socialPostDao =
      SocialPostDao(this as SocialFeedDatabase);
  late final SocialPostCommentDao socialPostCommentDao =
      SocialPostCommentDao(this as SocialFeedDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [socialPostDtos, socialPostCommentDtos];
}
