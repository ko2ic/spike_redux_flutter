import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/hoge_state.dart';

final hogeReducer = combineReducers<HogeState>([
  TypedReducer<HogeState, HogeSucceededAction>(_set),
]);

HogeState _set(HogeState hogeState, HogeSucceededAction action) {
  var entity = action.entity;
  return HogeState(
    fuga: entity.fuga,
  );
}
