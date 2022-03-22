import 'package:freezed_annotation/freezed_annotation.dart';

part 's_resource.freezed.dart';

@freezed
class SResource<T> with _$SResource {
  const factory SResource.success(T data) = SuperSuccess;

  const factory SResource.loading({@Default(-1) int progress, T? data}) =
      SuperLoading;

  const factory SResource.error(Exception error, {T? data}) = SuperError;

  const factory SResource.nothing() = SuperIdleOrNoData;
}

extension SResourceExtension<T> on SResource<T> {
  T? get successOrNull => maybeMap(
        success: (resource) => resource.data as T,
        orElse: () => null,
      );
}
