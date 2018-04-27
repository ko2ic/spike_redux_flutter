

import 'package:spike_redux_flutter/redux/reducer/loading_reducer.dart';
import 'package:spike_redux_flutter/redux/reducer/repo_list_reducer.dart';
import 'package:spike_redux_flutter/redux/reducer/favorite_reducer.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';

AppState appReducer(AppState state, action) {
  return new AppState(
    isLoading: loadingReducer(state.isLoading, action),
    repoList: repoListReducer(state.repoList, action),
    favoriteState: favoritesReducer(state.favoriteState, action),
  );
}
