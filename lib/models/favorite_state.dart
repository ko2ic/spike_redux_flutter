import 'package:flutter/foundation.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';


@immutable
class FavoriteState {

  final List<RepoEntity> favoriteList; // TODO const setできないからListにしている

  const FavoriteState({this.favoriteList});

  static FavoriteState copyWith({
    List<RepoEntity> favoriteList,
  }) {
    return new FavoriteState(
        favoriteList: favoriteList ?? [],
    );
  }
}

class FavoriteItemState {

  final bool isFavorite;

  const FavoriteItemState({this.isFavorite});

  static FavoriteItemState copyWith({
    bool isFavorite,
  }) {
    return new FavoriteItemState(
      isFavorite: isFavorite,
    );
  }
}