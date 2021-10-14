// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DataStateTearOff {
  const _$DataStateTearOff();

  Data<T> success<T>(T data) {
    return Data<T>(
      data,
    );
  }

  Loading<T> loading<T>({int progress = -1, T? data}) {
    return Loading<T>(
      progress: progress,
      data: data,
    );
  }

  Error<T> error<T>(Exception error, {T? data}) {
    return Error<T>(
      error,
      data: data,
    );
  }

  IdleOrNoData<T> idleOrNoData<T>() {
    return IdleOrNoData<T>();
  }
}

/// @nodoc
const $DataState = _$DataStateTearOff();

/// @nodoc
mixin _$DataState<T> {
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
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(IdleOrNoData<T> value) idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<T, $Res> {
  factory $DataStateCopyWith(
          DataState<T> value, $Res Function(DataState<T>) then) =
      _$DataStateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$DataStateCopyWithImpl<T, $Res> implements $DataStateCopyWith<T, $Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  final DataState<T> _value;
  // ignore: unused_field
  final $Res Function(DataState<T>) _then;
}

/// @nodoc
abstract class $DataCopyWith<T, $Res> {
  factory $DataCopyWith(Data<T> value, $Res Function(Data<T>) then) =
      _$DataCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class _$DataCopyWithImpl<T, $Res> extends _$DataStateCopyWithImpl<T, $Res>
    implements $DataCopyWith<T, $Res> {
  _$DataCopyWithImpl(Data<T> _value, $Res Function(Data<T>) _then)
      : super(_value, (v) => _then(v as Data<T>));

  @override
  Data<T> get _value => super._value as Data<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(Data<T>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$Data<T> implements Data<T> {
  const _$Data(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'DataState<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $DataCopyWith<T, Data<T>> get copyWith =>
      _$DataCopyWithImpl<T, Data<T>>(this, _$identity);

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
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(IdleOrNoData<T> value) idleOrNoData,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Data<T> implements DataState<T> {
  const factory Data(T data) = _$Data<T>;

  T get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<T, Data<T>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoadingCopyWith<T, $Res> {
  factory $LoadingCopyWith(Loading<T> value, $Res Function(Loading<T>) then) =
      _$LoadingCopyWithImpl<T, $Res>;
  $Res call({int progress, T? data});
}

/// @nodoc
class _$LoadingCopyWithImpl<T, $Res> extends _$DataStateCopyWithImpl<T, $Res>
    implements $LoadingCopyWith<T, $Res> {
  _$LoadingCopyWithImpl(Loading<T> _value, $Res Function(Loading<T>) _then)
      : super(_value, (v) => _then(v as Loading<T>));

  @override
  Loading<T> get _value => super._value as Loading<T>;

  @override
  $Res call({
    Object? progress = freezed,
    Object? data = freezed,
  }) {
    return _then(Loading<T>(
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

class _$Loading<T> implements Loading<T> {
  const _$Loading({this.progress = -1, this.data});

  @JsonKey(defaultValue: -1)
  @override
  final int progress;
  @override
  final T? data;

  @override
  String toString() {
    return 'DataState<$T>.loading(progress: $progress, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Loading<T> &&
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
  $LoadingCopyWith<T, Loading<T>> get copyWith =>
      _$LoadingCopyWithImpl<T, Loading<T>>(this, _$identity);

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
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(IdleOrNoData<T> value) idleOrNoData,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements DataState<T> {
  const factory Loading({int progress, T? data}) = _$Loading<T>;

  int get progress => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoadingCopyWith<T, Loading<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) then) =
      _$ErrorCopyWithImpl<T, $Res>;
  $Res call({Exception error, T? data});
}

/// @nodoc
class _$ErrorCopyWithImpl<T, $Res> extends _$DataStateCopyWithImpl<T, $Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(Error<T> _value, $Res Function(Error<T>) _then)
      : super(_value, (v) => _then(v as Error<T>));

  @override
  Error<T> get _value => super._value as Error<T>;

  @override
  $Res call({
    Object? error = freezed,
    Object? data = freezed,
  }) {
    return _then(Error<T>(
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

class _$Error<T> implements Error<T> {
  const _$Error(this.error, {this.data});

  @override
  final Exception error;
  @override
  final T? data;

  @override
  String toString() {
    return 'DataState<$T>.error(error: $error, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error<T> &&
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
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);

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
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(IdleOrNoData<T> value) idleOrNoData,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements DataState<T> {
  const factory Error(Exception error, {T? data}) = _$Error<T>;

  Exception get error => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdleOrNoDataCopyWith<T, $Res> {
  factory $IdleOrNoDataCopyWith(
          IdleOrNoData<T> value, $Res Function(IdleOrNoData<T>) then) =
      _$IdleOrNoDataCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$IdleOrNoDataCopyWithImpl<T, $Res>
    extends _$DataStateCopyWithImpl<T, $Res>
    implements $IdleOrNoDataCopyWith<T, $Res> {
  _$IdleOrNoDataCopyWithImpl(
      IdleOrNoData<T> _value, $Res Function(IdleOrNoData<T>) _then)
      : super(_value, (v) => _then(v as IdleOrNoData<T>));

  @override
  IdleOrNoData<T> get _value => super._value as IdleOrNoData<T>;
}

/// @nodoc

class _$IdleOrNoData<T> implements IdleOrNoData<T> {
  const _$IdleOrNoData();

  @override
  String toString() {
    return 'DataState<$T>.idleOrNoData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is IdleOrNoData<T>);
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
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(IdleOrNoData<T> value) idleOrNoData,
  }) {
    return idleOrNoData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
  }) {
    return idleOrNoData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(IdleOrNoData<T> value)? idleOrNoData,
    required TResult orElse(),
  }) {
    if (idleOrNoData != null) {
      return idleOrNoData(this);
    }
    return orElse();
  }
}

abstract class IdleOrNoData<T> implements DataState<T> {
  const factory IdleOrNoData() = _$IdleOrNoData<T>;
}
