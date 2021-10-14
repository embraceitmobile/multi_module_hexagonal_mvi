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
