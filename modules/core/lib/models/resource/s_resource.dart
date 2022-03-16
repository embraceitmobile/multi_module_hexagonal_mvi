import 'package:freezed_annotation/freezed_annotation.dart';

part 's_resource.freezed.dart';

@freezed
class SResource<T> with _$DataSuperState {
  const factory SResource.success(T data) = SuperSuccess;

  const factory SResource.loading({@Default(-1) int progress, T? data}) =
      SuperLoading;

  const factory SResource.error(Exception error, {T? data}) = SuperError;

  const factory SResource.idleOrNoData() = SuperIdleOrNoData;
}

extension SResourceTransformations<T> on SResource<T> {
  SResource<T> transformOnly<TResult extends Object?>({
    SResource<T> Function(T data)? success,
    SResource<T> Function(int progress, T? data)? loading,
    SResource<T> Function(Exception error, T? data)? error,
    SResource<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (resource) => success == null
            ? resource as SResource<T>
            : success(resource as T),
        loading: (resource) => loading == null
            ? resource as SResource<T>
            : loading(resource.progress, resource.data as T),
        error: (resource) => error == null
            ? resource as SResource<T>
            : error(resource.error, resource.data as T),
        idleOrNoData: (resource) => resource as SResource<T>,
      );
}
