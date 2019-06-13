import 'package:flutter/foundation.dart';
import 'package:mockito/mockito.dart';
import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/repositories/hoge_repository.dart';
import 'package:spike_redux_flutter/repositories/http/hoge_http_client.dart';
import 'package:test_api/test_api.dart';

class MockHogeHttpClient extends Mock implements HogeHttpClient {}

main() {
  group('fetch()', () {
    var client =  MockHogeHttpClient();

    test('return null.', () async {
      when(client.fetch()).thenAnswer((_) => Future.value(null));

      var target = HogeRepository(client);
      var actual = await target.fetch();

      expect(actual, isNull);

      reset(client);
    });

    test('return entity', () async {
      var entity = HogeEntity(fuga: "fuga");

      when(client.fetch()).thenAnswer((_) => SynchronousFuture(entity));

      var target = HogeRepository(client);
      var actual = await target.fetch();

      expect(actual.fuga, "fuga");

      reset(client);
    });
  });
}
