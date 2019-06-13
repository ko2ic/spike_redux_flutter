import 'package:flutter/foundation.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';


@immutable
class FavoriteState {

  final List<RepoEntity> favoriteList; // TODO const setできないからListにしている

  const FavoriteState({this.favoriteList});

  FavoriteState copyWith({
    List<RepoEntity> favoriteList,
  }) {
    return  FavoriteState(
        favoriteList: favoriteList ?? [],
    );
  }
}

