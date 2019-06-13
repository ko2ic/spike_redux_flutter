import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/favorite_state.dart';

final favoritesReducer = combineReducers<FavoriteState>([
  TypedReducer<FavoriteState, FavoriteAction>(_setFavorite),
]);

FavoriteState _setFavorite(FavoriteState state, FavoriteAction action) {
  var newList = List<RepoEntity>();
  newList.addAll(state.favoriteList);

  if (newList.contains(action.target)) {
    newList.remove(action.target);
  } else {
    newList.add(action.target);
  }

  return FavoriteState(favoriteList: newList);
}
