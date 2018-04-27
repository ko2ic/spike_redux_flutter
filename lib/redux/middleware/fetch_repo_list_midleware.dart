import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/models/search_result_dto.dart';
import 'package:spike_redux_flutter/repositories/github_repository_impl.dart';


void fetchRepoListMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchRepoListAction) {
    final repository = new GithubRepositoryImpl();
    next(new LoadingAction());
    repository.fetch(action.keyword).then((SearchResultDto dto) {
      next(new FetchRepoListSucceededAction(dto.items));
    }).catchError((Exception error) {
      next(new FetchRepoListFailedAction(error));
    }).whenComplete(() => next(new LoadCompleteAction()));
  }
  next(action);
}