import 'package:core/core.dart';
import 'package:core/helpers/network_bound_resource.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/mock_local_data_source.dart';
import 'mocks/mock_object.dart';

void main() {
  late final MockLocalDatasource<MockObject> _localDatasource;
  setUpAll(() => _localDatasource = MockLocalDatasource());
  tearDownAll(() => _localDatasource.dispose());

  group('Objects are correctly initializd and processing methods work properly',
      () {
    NetworkBoundResource<MockObject>? _nbr;

    setUp(() async {
      _nbr = NetworkBoundResource<MockObject>(
          shouldFetch: () async => true,
          onFetchLocalData: () async =>
              _localDatasource.findByAll().then((value) => value.first),
          onFetchRemoteData: () async => MockObject(
                uniqueKey: "1",
                value: "value_new",
              ),
          onSaveResultToLocal: (value) async {
            await _localDatasource.insert(value);
          },
          localDataSourceObservable:
              _localDatasource.observeChanges().map((event) {
            if (event.isEmpty) return null;
            return event.first;
          }).toDataStateStream);
    });

    tearDown(() async => await _localDatasource.clear());

    test(
        'On constructing new network_bound_resource, the value and its fields are not null',
        () async {
      expect(_nbr, isNotNull);
      expect(_nbr?.shouldFetch, isNotNull);
      expect(_nbr?.onFetchRemoteData, isNotNull);
      expect(_nbr?.onFetchLocalData, isNotNull);
      expect(_nbr?.onSaveResultToLocal, isNotNull);
      expect(_nbr?.localDataSourceObservable, isNotNull);
    });

    test('On calling fetch, the correct value is returned', () async {
      expect(
        await _nbr!.fetch(),
        equals(MockObject(
          uniqueKey: "1",
          value: "value_new",
        )),
      );
    });

    test('On calling fetch, local datasource is updated', () async {
      await _nbr!.fetch();
      expect(
        await _localDatasource.findById("1"),
        equals(MockObject(
          uniqueKey: "1",
          value: "value_new",
        )),
      );
    });

    test('On calling fetch, the dataListener emits the correct data', () async {
      List<Resource> expectedResults = [
        Resource.loading(),
        Resource.success(MockObject(uniqueKey: "1", value: "value_new")),
        Resource.nothing(), //called due to tearDown
      ];

      int i = 0;
      _nbr!.dataListener.listen(expectAsync1((event) {
        expect(event, equals(expectedResults[i]));
        i++;
      }, count: 2, max: 3));
    });
  });
}
