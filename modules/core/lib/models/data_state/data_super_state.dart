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
        success: (dataState) => success == null
            ? dataState as DataSuperState<T>
            : success(dataState as T),
        loading: (dataState) => loading == null
            ? dataState as DataSuperState<T>
            : loading(dataState.progress, dataState.data as T),
        error: (dataState) => error == null
            ? dataState as DataSuperState<T>
            : error(dataState.error, dataState.data as T),
        idleOrNoData: (dataState) => dataState as DataSuperState<T>,
      );
}
