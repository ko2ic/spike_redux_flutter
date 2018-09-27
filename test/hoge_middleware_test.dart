import 'dart:async';
import 'package:matcher/matcher.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/repositories/hoge_repository.dart';
import 'package:spike_redux_flutter/redux/middleware/hoge_middleware.dart';
import 'package:spike_redux_flutter/redux/reducer/app_state_reducer.dart';

class MockMiddleware extends Mock implements MiddlewareClass<AppState> {}

class MockHogeRepository extends Mock implements HogeRepository {}

main() {
  group('HogeMiddleware', () {
    final repository = MockHogeRepository();
    final captor = MockMiddleware();

    test('should fetch hoge', () async {
      final store = Store<AppState>(
        appReducer,
        initialState: new AppState.loading(),
        middleware: hogeMiddleware(repository)..add(captor),
      );

      var entity = HogeEntity(
        fuga: "fuga",
      );

      when(repository.fetch()).thenAnswer((_) => Future.value(entity));

      store.dispatch(HogeAction());

      verify(repository.fetch());

      verify(captor.call(store, predicate((action) {
        return (action is HogeAction);
      }), any));

      verify(captor.call(store, predicate((action) {
        return (action is LoadingAction);
      }), any));

      await untilCalled(store.dispatch(any));

      verify(captor.call(store, predicate((action) {
        if (action is HogeSucceededAction) {
          return action.entity.fuga == 'fuga';
        }
        return false;
      }), any));

      verify(captor.call(store, predicate((action) {
        return (action is LoadCompleteAction);
      }), any));
    });

    reset(repository);
    reset(captor);
  });
}
