
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  new TypedReducer<bool, RepoListLoadedAction>(_setLoaded),
  new TypedReducer<bool, RepoListNotLoadedAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
