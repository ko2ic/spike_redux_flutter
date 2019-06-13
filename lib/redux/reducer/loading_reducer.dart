
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';

final loadingReducer = combineReducers<bool>([
   TypedReducer<bool, LoadingAction>( (state, action) => true),
   TypedReducer<bool, LoadCompleteAction>((state, action) => false),
]);

