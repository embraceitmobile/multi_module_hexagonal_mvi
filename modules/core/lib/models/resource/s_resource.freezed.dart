// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 's_resource.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DataSuperStateTearOff {
  const _$DataSuperStateTearOff();

  SuperSuccess<T> success<T>(T data) {
    return SuperSuccess<T>(
      data,
    );
  }

  SuperLoading<T> loading<T>({int progress = -1, T? data}) {
    return SuperLoading<T>(
      progress: progress,
      data: data,
    );
  }

  SuperError<T> error<T>(Exception error, {T? data}) {
    return SuperError<T>(
      error,
      data: data,
    );
  }

  SuperIdleOrNoData<T> idleOrNoData<T>() {
    return SuperIdleOrNoData<T>();
  }
}

/// @nodoc
const $DataSuperState = _$DataSuperStateTearOff();

/// @nodoc
mixin _$DataSuperState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(int progress, T? data) loading,
    required TResult Function(Exception error, T? data) error,
    required TResult Function() idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuperSuccess<T> value) success,
    required TResult Function(SuperLoading<T> value) loading,
    required TResult Function(SuperError<T> value) error,
    required TResult Function(SuperIdleOrNoData<T> value) idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataSuperStateCopyWith<T, $Res> {
  factory $DataSuperStateCopyWith(
          SResource<T> value, $Res Function(SResource<T>) then) =
      _$DataSuperStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$DataSuperStateCopyWithImpl<T, $Res>
    implements $DataSuperStateCopyWith<T, $Res> {
  _$DataSuperStateCopyWithImpl(this._value, this._then);

  final SResource<T> _value;
  // ignore: unused_field
  final $Res Function(SResource<T>) _then;
}

/// @nodoc
abstract class $SuperSuccessCopyWith<T, $Res> {
  factory $SuperSuccessCopyWith(
          SuperSuccess<T> value, $Res Function(SuperSuccess<T>) then) =
      _$SuperSuccessCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class _$SuperSuccessCopyWithImpl<T, $Res>
    extends _$DataSuperStateCopyWithImpl<T, $Res>
    implements $SuperSuccessCopyWith<T, $Res> {
  _$SuperSuccessCopyWithImpl(
      SuperSuccess<T> _value, $Res Function(SuperSuccess<T>) _then)
      : super(_value, (v) => _then(v as SuperSuccess<T>));

  @override
  SuperSuccess<T> get _value => super._value as SuperSuccess<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(SuperSuccess<T>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SuperSuccess<T> implements SuperSuccess<T> {
  const _$SuperSuccess(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'DataSuperState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SuperSuccess<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $SuperSuccessCopyWith<T, SuperSuccess<T>> get copyWith =>
      _$SuperSuccessCopyWithImpl<T, SuperSuccess<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(int progress, T? data) loading,
    required TResult Function(Exception error, T? data) error,
    required TResult Function() idleOrNoData,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuperSuccess<T> value) success,
    required TResult Function(SuperLoading<T> value) loading,
    required TResult Function(SuperError<T> value) error,
    required TResult Function(SuperIdleOrNoData<T> value) idleOrNoData,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SuperSuccess<T> implements SResource<T> {
  const factory SuperSuccess(T data) = _$SuperSuccess<T>;

  T get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuperSuccessCopyWith<T, SuperSuccess<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperLoadingCopyWith<T, $Res> {
  factory $SuperLoadingCopyWith(
          SuperLoading<T> value, $Res Function(SuperLoading<T>) then) =
      _$SuperLoadingCopyWithImpl<T, $Res>;
  $Res call({int progress, T? data});
}

/// @nodoc
class _$SuperLoadingCopyWithImpl<T, $Res>
    extends _$DataSuperStateCopyWithImpl<T, $Res>
    implements $SuperLoadingCopyWith<T, $Res> {
  _$SuperLoadingCopyWithImpl(
      SuperLoading<T> _value, $Res Function(SuperLoading<T>) _then)
      : super(_value, (v) => _then(v as SuperLoading<T>));

  @override
  SuperLoading<T> get _value => super._value as SuperLoading<T>;

  @override
  $Res call({
    Object? progress = freezed,
    Object? data = freezed,
  }) {
    return _then(SuperLoading<T>(
      progress: progress == freezed
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$SuperLoading<T> implements SuperLoading<T> {
  const _$SuperLoading({this.progress = -1, this.data});

  @JsonKey(defaultValue: -1)
  @override
  final int progress;
  @override
  final T? data;

  @override
  String toString() {
    return 'DataSuperState<$T>.loading(progress: $progress, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SuperLoading<T> &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality()
                    .equals(other.progress, progress)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $SuperLoadingCopyWith<T, SuperLoading<T>> get copyWith =>
      _$SuperLoadingCopyWithImpl<T, SuperLoading<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(int progress, T? data) loading,
    required TResult Function(Exception error, T? data) error,
    required TResult Function() idleOrNoData,
  }) {
    return loading(progress, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
  }) {
    return loading?.call(progress, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(progress, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuperSuccess<T> value) success,
    required TResult Function(SuperLoading<T> value) loading,
    required TResult Function(SuperError<T> value) error,
    required TResult Function(SuperIdleOrNoData<T> value) idleOrNoData,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SuperLoading<T> implements SResource<T> {
  const factory SuperLoading({int progress, T? data}) = _$SuperLoading<T>;

  int get progress => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuperLoadingCopyWith<T, SuperLoading<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperErrorCopyWith<T, $Res> {
  factory $SuperErrorCopyWith(
          SuperError<T> value, $Res Function(SuperError<T>) then) =
      _$SuperErrorCopyWithImpl<T, $Res>;
  $Res call({Exception error, T? data});
}

/// @nodoc
class _$SuperErrorCopyWithImpl<T, $Res>
    extends _$DataSuperStateCopyWithImpl<T, $Res>
    implements $SuperErrorCopyWith<T, $Res> {
  _$SuperErrorCopyWithImpl(
      SuperError<T> _value, $Res Function(SuperError<T>) _then)
      : super(_value, (v) => _then(v as SuperError<T>));

  @override
  SuperError<T> get _value => super._value as SuperError<T>;

  @override
  $Res call({
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(SuperError<T>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$SuperError<T> implements SuperError<T> {
  const _$SuperError(this.error, {this.data});

  @override
  final Exception error;
  @override
  final T? data;

  @override
  String toString() {
    return 'DataSuperState<$T>.error(error: $error, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SuperError<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $SuperErrorCopyWith<T, SuperError<T>> get copyWith =>
      _$SuperErrorCopyWithImpl<T, SuperError<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(int progress, T? data) loading,
    required TResult Function(Exception error, T? data) error,
    required TResult Function() idleOrNoData,
  }) {
    return error(this.error, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
  }) {
    return error?.call(this.error, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuperSuccess<T> value) success,
    required TResult Function(SuperLoading<T> value) loading,
    required TResult Function(SuperError<T> value) error,
    required TResult Function(SuperIdleOrNoData<T> value) idleOrNoData,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SuperError<T> implements SResource<T> {
  const factory SuperError(Exception error, {T? data}) = _$SuperError<T>;

  Exception get error => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuperErrorCopyWith<T, SuperError<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuperIdleOrNoDataCopyWith<T, $Res> {
  factory $SuperIdleOrNoDataCopyWith(SuperIdleOrNoData<T> value,
          $Res Function(SuperIdleOrNoData<T>) then) =
      _$SuperIdleOrNoDataCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$SuperIdleOrNoDataCopyWithImpl<T, $Res>
    extends _$DataSuperStateCopyWithImpl<T, $Res>
    implements $SuperIdleOrNoDataCopyWith<T, $Res> {
  _$SuperIdleOrNoDataCopyWithImpl(
      SuperIdleOrNoData<T> _value, $Res Function(SuperIdleOrNoData<T>) _then)
      : super(_value, (v) => _then(v as SuperIdleOrNoData<T>));

  @override
  SuperIdleOrNoData<T> get _value => super._value as SuperIdleOrNoData<T>;
}

/// @nodoc

class _$SuperIdleOrNoData<T> implements SuperIdleOrNoData<T> {
  const _$SuperIdleOrNoData();

  @override
  String toString() {
    return 'DataSuperState<$T>.idleOrNoData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SuperIdleOrNoData<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(int progress, T? data) loading,
    required TResult Function(Exception error, T? data) error,
    required TResult Function() idleOrNoData,
  }) {
    return idleOrNoData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
  }) {
    return idleOrNoData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(int progress, T? data)? loading,
    TResult Function(Exception error, T? data)? error,
    TResult Function()? idleOrNoData,
    required TResult orElse(),
  }) {
    if (idleOrNoData != null) {
      return idleOrNoData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuperSuccess<T> value) success,
    required TResult Function(SuperLoading<T> value) loading,
    required TResult Function(SuperError<T> value) error,
    required TResult Function(SuperIdleOrNoData<T> value) idleOrNoData,
  }) {
    return idleOrNoData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
  }) {
    return idleOrNoData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuperSuccess<T> value)? success,
    TResult Function(SuperLoading<T> value)? loading,
    TResult Function(SuperError<T> value)? error,
    TResult Function(SuperIdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (idleOrNoData != null) {
      return idleOrNoData(this);
    }
    return orElse();
  }
}

abstract class SuperIdleOrNoData<T> implements SResource<T> {
  const factory SuperIdleOrNoData() = _$SuperIdleOrNoData<T>;
}
