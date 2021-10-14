import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState {
  const factory DataState.success(T data) = Success;
  const factory DataState.loading({@Default(-1) int progress}) = Loading;
  const factory DataState.error(Exception error) = Error;
  const factory DataState.idleOrNoData() = IdleOrNoData;
}
