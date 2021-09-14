import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$State {
  const factory DataState.success(T data) = Data;
  const factory DataState.loading() = Loading;
  const factory DataState.error(Exception error) = Error;
  const factory DataState.nullOrEmpty() = NullOrEmpty;
}
