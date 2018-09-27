import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/repositories/hoge_repository.dart';

List<Middleware<AppState>> hogeMiddleware(
  HogeRepository repository,
) {
  return [
    TypedMiddleware<AppState, HogeAction>(_fetchHoge(repository)),
  ];
}

void Function(
  Store<AppState> store,
  HogeAction action,
  NextDispatcher next,
) _fetchHoge(
  HogeRepository repository,
) {
  return (store, action, next) {
    next(action);
    next(LoadingAction());

    repository.fetch().then((HogeEntity entity) {
      store.dispatch(HogeSucceededAction(entity));
    }).catchError((error) {
      print(error);
    }).whenComplete(() {
      next(LoadCompleteAction());
    });
  };
}
