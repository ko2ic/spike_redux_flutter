import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/actions/actions.dart';
import 'package:spike_redux_flutter/models/app_state.dart';
import 'package:spike_redux_flutter/models/search_result_dto.dart';
import 'package:spike_redux_flutter/repositories/github_repository_impl.dart';


void fetchRepoListMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchRepoListAction) {
    final repository = new GithubRepositoryImpl(); // Create our pseudo-api for fetching todos
    repository.fetch(action.keyword).then((SearchResultDto dto) {
      store.dispatch(new FetchRepoListSucceededAction(dto.items));
    }).catchError((Exception error) {
      store.dispatch(new FetchRepoListFailedAction(error));
    });
  }
  next(action);
}