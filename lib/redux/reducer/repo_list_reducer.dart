
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';

final repoListReducer = combineReducers<List<RepoEntity>>([
  new TypedReducer<List<RepoEntity>, FetchRepoListSucceededAction>(_setLoadedRepoList),
  new TypedReducer<List<RepoEntity>, FetchRepoListFailedAction>(_setNoRepoList),
]);


List<RepoEntity> _setLoadedRepoList(List<RepoEntity> repoList, FetchRepoListSucceededAction action) {
  return action.items;
}

List<RepoEntity> _setNoRepoList(List<RepoEntity> repoList, FetchRepoListFailedAction action) {
  return [];
}

