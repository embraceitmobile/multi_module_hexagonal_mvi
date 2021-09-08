import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class State<T> with _$State {
  const factory State.success(T data) = Data;
  const factory State.loading() = Loading;
  const factory State.error(Exception error) = Error;
  const factory State.nullOrEmpty() = NullOrEmpty;
}
