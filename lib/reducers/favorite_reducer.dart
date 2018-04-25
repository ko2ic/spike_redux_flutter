
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import 'package:spike_redux_flutter/actions/actions.dart';
import 'package:spike_redux_flutter/models/favorite_state.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';

final favoriteReducer = combineReducers<FavoriteState>([
  new TypedReducer<FavoriteState, FavoriteAction>(_setFavoriteState),
]);


FavoriteState _setFavoriteState(@immutable FavoriteState state, @immutable FavoriteAction action) {
  var entity = action.entity;
  List<RepoEntity> newFavoriteList =   [];
  newFavoriteList.addAll(state.favoriteList);
  if (newFavoriteList.contains(entity)){
    newFavoriteList.remove(entity);
  }else{
    var newEntity = entity.copyWith(isFavorite: true);
    newFavoriteList.add(newEntity);
  }

  FavoriteState newState = FavoriteState.copyWith(
      favoriteList: newFavoriteList,
      );

  return newState;
}

