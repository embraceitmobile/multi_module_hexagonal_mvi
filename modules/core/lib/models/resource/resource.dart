import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';

@freezed
class Resource<T> with _$Resource {
  const factory Resource.success(T data) = Success;

  const factory Resource.loading({@Default(-1) int progress}) = Loading;

  const factory Resource.error(Exception error) = Error;

  const factory Resource.nothing() = Nothing;
}

extension ResourceTransformations<T> on Resource<T> {
  Resource<T> transformOnly<TResult extends Object?>({
    Resource<T> Function(T data)? success,
    Resource<T> Function(int progress)? loading,
    Resource<T> Function(Exception error)? error,
    Resource<T> Function()? idleOrNoData,
  }) =>
      this.map(
        success: (resource) => success == null
            ? resource as Resource<T>
            : success(resource as T),
        loading: (resource) => loading == null
            ? resource as Resource<T>
            : loading(resource as int),
        error: (resource) => error == null
            ? resource as Resource<T>
            : error(resource as Exception),
        nothing: (resource) => resource as Resource<T>,
      );
}
