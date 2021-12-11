import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState {
  const factory DataState.success(T data) = Success;

  const factory DataState.loading({@Default(-1) int progress}) = Loading;

  const factory DataState.error(Exception error) = Error;

  const factory DataState.nothing() = Nothing;
}

extension DataStateTransformations<T> on DataState<T> {
  DataState<T> transformOnly<TResult extends Object?>({
    DataState<T> Function(T data)? success,
    DataState<T> Function(int progress)? loading,
    DataState<T> Function(Exception error)? error,
    DataState<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (dataState) => success == null
            ? dataState as DataState<T>
            : success(dataState as T),
        loading: (dataState) => loading == null
            ? dataState as DataState<T>
            : loading(dataState as int),
        error: (dataState) => error == null
            ? dataState as DataState<T>
            : error(dataState as Exception),
        nothing: (dataState) => dataState as DataState<T>,
      );
}
