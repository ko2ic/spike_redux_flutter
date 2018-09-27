import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/search_result_dto.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/repositories/github_repository_impl.dart';

List<Middleware<AppState>> fetchRepoListMiddleware(
  GithubRepositoryImpl repository,
) {
  return [
    TypedMiddleware<AppState, FetchRepoListAction>(
      _load(repository),
    ),
  ];
}

void Function(
  Store<AppState> store,
  FetchRepoListAction action,
  NextDispatcher next,
) _load(
  GithubRepositoryImpl repository,
) {
  return (store, action, next) {
    next(action);
    next(new LoadingAction());
    repository.fetch(action.keyword).then((SearchResultDto dto) {
      next(new FetchRepoListSucceededAction(dto.items));
    }).catchError((Exception error) {
      next(new FetchRepoListFailedAction(error));
    }).whenComplete(() => next(new LoadCompleteAction()));
  };
}
