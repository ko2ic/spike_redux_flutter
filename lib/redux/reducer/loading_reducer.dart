
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';

final loadingReducer = combineReducers<bool>([
  new TypedReducer<bool, LoadingAction>( (state, action) => true),
  new TypedReducer<bool, LoadCompleteAction>((state, action) => false),
]);

