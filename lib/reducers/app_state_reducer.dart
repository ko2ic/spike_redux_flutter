

import 'package:spike_redux_flutter/reducers/loading_reducer.dart';
import 'package:spike_redux_flutter/reducers/repo_list_reducer.dart';
import 'package:spike_redux_flutter/reducers/favorite_reducer.dart';
import 'package:spike_redux_flutter/models/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    repoList: repoListReducer(state.repoList, action),
    favoriteState: favoriteReducer(state.favoriteState, action),
  );
}
