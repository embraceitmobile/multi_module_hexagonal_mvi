import 'package:core/helpers/network_bound_resource.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_local_data_source.dart';
import 'mocks/mock_object.dart';

void main() {
  late final MockLocalDatasource<MockObject> _localDatasource;
  setUpAll(() => _localDatasource = MockLocalDatasource());
  tearDownAll(() => _localDatasource.dispose());

  group('New network_bound_resource initialization', () {
    NetworkBoundResource<MockObject>? _nbr;

    setUp(() async {
      _nbr = NetworkBoundResource<MockObject>(
          shouldFetch: () async => true,
          onFetchCachedData: () async {
            final result = await _localDatasource.findByAll();
            return Future.value(result as MockObject);
          },
          onFetchFromRemoteDatasource: () async => MockObject(
                uniqueKey: "1",
                value: "value_new",
              ),
          onSaveResultToCache: (value) async {
            await _localDatasource.insert(value);
          },
          localDatasourceListener: _localDatasource
              .observeChanges()
              .map((event) => event.first)
              .toDataStateStream);
    });
    tearDown(() async => await _localDatasource.clear());

    test(
        'On constructing new network_bound_resource, the value and its fields are not null',
        () async {
      expect(_nbr, isNotNull);
      expect(_nbr?.shouldFetch, isNotNull);
      expect(_nbr?.onFetchFromRemoteDatasource, isNotNull);
      expect(_nbr?.onFetchCachedData, isNotNull);
      expect(_nbr?.onSaveResultToCache, isNotNull);
      expect(_nbr?.localDatasourceListener, isNotNull);
    });
  });
}
