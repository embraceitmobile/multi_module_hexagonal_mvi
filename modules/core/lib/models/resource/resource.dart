import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource {
  const factory Resource.success(T data) = Success;

  const factory Resource.loading({@Default(-1) int progress}) = Loading;

  const factory Resource.error(Exception error) = Error;

  const factory Resource.nothing() = Nothing;
}

extension ResourceExtension<T> on Resource<T> {
  T? get successOrNull => maybeMap(
        success: (resource) => resource.data as T,
        orElse: () => null,
      );

  TResult mapSuccessOnly<TResult extends Object?>(
      TResult Function(Success<T> value) success) =>
      map(
        success: (resource) => success(resource.data),
        nothing: (resource) => resource as TResult,
        loading: (resource) => resource as TResult,
        error: (resource) => resource as TResult,
      );
}
