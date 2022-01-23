import 'package:flutter_test/flutter_test.dart';

import 'mock_local_data_source.dart';
import 'mock_object.dart';

void main() {
  late final MockLocalDatasource<MockObject> _localDatasource;
  setUpAll(() => _localDatasource = MockLocalDatasource());
  tearDownAll(() => _localDatasource.dispose());

  test('Correct object is emitted on inserting object', () {
    final objectToTest = MockObject(uniqueKey: "1", value: "value");
    _localDatasource.observeChanges().listen(expectAsync1((value) {
      expect(value.first, equals(objectToTest));
    }));
    _localDatasource.insert(objectToTest);
  });
}
