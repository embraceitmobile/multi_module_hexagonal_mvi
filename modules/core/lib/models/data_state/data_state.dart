import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState {
  const factory DataState.success(T data) = Success;

  const factory DataState.loading({@Default(-1) int progress}) = Loading;

  const factory DataState.error(Exception error) = Error;

  const factory DataState.idleOrNoData() = IdleOrNoData;
}

extension DataStateTransformations<T> on DataState<T> {
  DataState<T> transformOnlyWhen<TResult extends Object?>({
    DataState<T> Function(T data)? success,
    DataState<T> Function(int progress)? loading,
    DataState<T> Function(Exception error)? error,
    DataState<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (data) =>
            success == null ? data as DataState<T> : success(data as T),
        loading: (data) =>
            loading == null ? data as DataState<T> : loading(data as int),
        error: (data) =>
            error == null ? data as DataState<T> : error(data as Exception),
        idleOrNoData: (data) => data as DataState<T>,
      );
}
