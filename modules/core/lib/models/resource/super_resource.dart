import 'package:freezed_annotation/freezed_annotation.dart';

part 'super_resource.freezed.dart';

@freezed
class SuperResource<T> with _$DataSuperState {
  const factory SuperResource.success(T data) = SuperSuccess;

  const factory SuperResource.loading({@Default(-1) int progress, T? data}) =
      SuperLoading;

  const factory SuperResource.error(Exception error, {T? data}) = SuperError;

  const factory SuperResource.idleOrNoData() = SuperIdleOrNoData;
}

extension SuperResourceTransformations<T> on SuperResource<T> {
  SuperResource<T> transformOnly<TResult extends Object?>({
    SuperResource<T> Function(T data)? success,
    SuperResource<T> Function(int progress, T? data)? loading,
    SuperResource<T> Function(Exception error, T? data)? error,
    SuperResource<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (resource) => success == null
            ? resource as SuperResource<T>
            : success(resource as T),
        loading: (resource) => loading == null
            ? resource as SuperResource<T>
            : loading(resource.progress, resource.data as T),
        error: (resource) => error == null
            ? resource as SuperResource<T>
            : error(resource.error, resource.data as T),
        idleOrNoData: (resource) => resource as SuperResource<T>,
      );
}
