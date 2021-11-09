import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_super_state.freezed.dart';

@freezed
class DataSuperState<T> with _$DataSuperState {
  const factory DataSuperState.success(T data) = SuperSuccess;

  const factory DataSuperState.loading({@Default(-1) int progress, T? data}) =
      SuperLoading;

  const factory DataSuperState.error(Exception error, {T? data}) = SuperError;

  const factory DataSuperState.idleOrNoData() = SuperIdleOrNoData;
}

extension DataSuperStateTransformations<T> on DataSuperState<T> {
  DataSuperState<T> transformOnly<TResult extends Object?>({
    DataSuperState<T> Function(T data)? success,
    DataSuperState<T> Function(int progress, T? data)? loading,
    DataSuperState<T> Function(Exception error, T? data)? error,
    DataSuperState<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (value) =>
            success == null ? value as DataSuperState<T> : success(value as T),
        loading: (value) => loading == null
            ? value as DataSuperState<T>
            : loading(value.progress, value.data as T),
        error: (value) => error == null
            ? value as DataSuperState<T>
            : error(value.error, value.data as T),
        idleOrNoData: (value) => value as DataSuperState<T>,
      );
}
