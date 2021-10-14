import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState {
  const factory DataState.success(T data) = Data;
  const factory DataState.loading({@Default(-1) int progress, T? data}) =
      Loading;
  const factory DataState.error(Exception error, {T? data}) = Error;
  const factory DataState.idleOrNoData() = IdleOrNoData;
}
