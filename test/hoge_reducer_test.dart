import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/reducer/app_state_reducer.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/redux/state/hoge_state.dart';
import 'package:test_api/test_api.dart';

main() {
  group('HogeReducer', () {
    final store =  Store<AppState>(
      appReducer,
      initialState:  AppState(
        hogeState: HogeState(
          fuga: 'fuga',
        ),
      ),
    );

    test('fugafuga', () {
      var entity = HogeEntity(
        fuga: 'fugafuga',
      );

      store.dispatch( HogeSucceededAction(entity));

      expect(store.state.hogeState.fuga, "fugafuga");
    });
  });
}
