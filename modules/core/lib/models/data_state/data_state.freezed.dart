// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$StateTearOff {
  const _$StateTearOff();

  Data<T> success<T>(T data) {
    return Data<T>(
      data,
    );
  }

  Loading<T> loading<T>() {
    return Loading<T>();
  }

  Error<T> error<T>(Exception error) {
    return Error<T>(
      error,
    );
  }

  NullOrEmpty<T> nullOrEmpty<T>() {
    return NullOrEmpty<T>();
  }
}

/// @nodoc
const $State = _$StateTearOff();

/// @nodoc
mixin _$State<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() loading,
    required TResult Function(Exception error) error,
    required TResult Function() nullOrEmpty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? loading,
    TResult Function(Exception error)? error,
    TResult Function()? nullOrEmpty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(NullOrEmpty<T> value) nullOrEmpty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(NullOrEmpty<T> value)? nullOrEmpty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StateCopyWith<T, $Res> {
  factory $StateCopyWith(DataState<T> value, $Res Function(DataState<T>) then) =
      _$StateCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$StateCopyWithImpl<T, $Res> implements $StateCopyWith<T, $Res> {
  _$StateCopyWithImpl(this._value, this._then);

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
class _$DataCopyWithImpl<T, $Res> extends _$StateCopyWithImpl<T, $Res>
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
    return 'State<$T>.success(data: $data)';
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
    required TResult Function() loading,
    required TResult Function(Exception error) error,
    required TResult Function() nullOrEmpty,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? loading,
    TResult Function(Exception error)? error,
    TResult Function()? nullOrEmpty,
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
    required TResult Function(NullOrEmpty<T> value) nullOrEmpty,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(NullOrEmpty<T> value)? nullOrEmpty,
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
}

/// @nodoc
class _$LoadingCopyWithImpl<T, $Res> extends _$StateCopyWithImpl<T, $Res>
    implements $LoadingCopyWith<T, $Res> {
  _$LoadingCopyWithImpl(Loading<T> _value, $Res Function(Loading<T>) _then)
      : super(_value, (v) => _then(v as Loading<T>));

  @override
  Loading<T> get _value => super._value as Loading<T>;
}

/// @nodoc

class _$Loading<T> implements Loading<T> {
  const _$Loading();

  @override
  String toString() {
    return 'State<$T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Loading<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() loading,
    required TResult Function(Exception error) error,
    required TResult Function() nullOrEmpty,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? loading,
    TResult Function(Exception error)? error,
    TResult Function()? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(NullOrEmpty<T> value) nullOrEmpty,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(NullOrEmpty<T> value)? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading<T> implements DataState<T> {
  const factory Loading() = _$Loading<T>;
}

/// @nodoc
abstract class $ErrorCopyWith<T, $Res> {
  factory $ErrorCopyWith(Error<T> value, $Res Function(Error<T>) then) =
      _$ErrorCopyWithImpl<T, $Res>;
  $Res call({Exception error});
}

/// @nodoc
class _$ErrorCopyWithImpl<T, $Res> extends _$StateCopyWithImpl<T, $Res>
    implements $ErrorCopyWith<T, $Res> {
  _$ErrorCopyWithImpl(Error<T> _value, $Res Function(Error<T>) _then)
      : super(_value, (v) => _then(v as Error<T>));

  @override
  Error<T> get _value => super._value as Error<T>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Error<T>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception,
    ));
  }
}

/// @nodoc

class _$Error<T> implements Error<T> {
  const _$Error(this.error);

  @override
  final Exception error;

  @override
  String toString() {
    return 'State<$T>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Error<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      _$ErrorCopyWithImpl<T, Error<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() loading,
    required TResult Function(Exception error) error,
    required TResult Function() nullOrEmpty,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? loading,
    TResult Function(Exception error)? error,
    TResult Function()? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(NullOrEmpty<T> value) nullOrEmpty,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(NullOrEmpty<T> value)? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error<T> implements DataState<T> {
  const factory Error(Exception error) = _$Error<T>;

  Exception get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorCopyWith<T, Error<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NullOrEmptyCopyWith<T, $Res> {
  factory $NullOrEmptyCopyWith(
          NullOrEmpty<T> value, $Res Function(NullOrEmpty<T>) then) =
      _$NullOrEmptyCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$NullOrEmptyCopyWithImpl<T, $Res> extends _$StateCopyWithImpl<T, $Res>
    implements $NullOrEmptyCopyWith<T, $Res> {
  _$NullOrEmptyCopyWithImpl(
      NullOrEmpty<T> _value, $Res Function(NullOrEmpty<T>) _then)
      : super(_value, (v) => _then(v as NullOrEmpty<T>));

  @override
  NullOrEmpty<T> get _value => super._value as NullOrEmpty<T>;
}

/// @nodoc

class _$NullOrEmpty<T> implements NullOrEmpty<T> {
  const _$NullOrEmpty();

  @override
  String toString() {
    return 'State<$T>.nullOrEmpty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NullOrEmpty<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() loading,
    required TResult Function(Exception error) error,
    required TResult Function() nullOrEmpty,
  }) {
    return nullOrEmpty();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? loading,
    TResult Function(Exception error)? error,
    TResult Function()? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (nullOrEmpty != null) {
      return nullOrEmpty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Data<T> value) success,
    required TResult Function(Loading<T> value) loading,
    required TResult Function(Error<T> value) error,
    required TResult Function(NullOrEmpty<T> value) nullOrEmpty,
  }) {
    return nullOrEmpty(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Data<T> value)? success,
    TResult Function(Loading<T> value)? loading,
    TResult Function(Error<T> value)? error,
    TResult Function(NullOrEmpty<T> value)? nullOrEmpty,
    required TResult orElse(),
  }) {
    if (nullOrEmpty != null) {
      return nullOrEmpty(this);
    }
    return orElse();
  }
}

abstract class NullOrEmpty<T> implements DataState<T> {
  const factory NullOrEmpty() = _$NullOrEmpty<T>;
}
