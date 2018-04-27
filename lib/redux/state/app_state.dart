
import 'package:flutter/foundation.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/redux/state/favorite_state.dart';

@immutable
class AppState {

  final bool isLoading;
  final List<RepoEntity> repoList;
  final FavoriteState favoriteState;

  const AppState(
      {
        this.isLoading = false,
        this.repoList = const [],
        this.favoriteState = const FavoriteState(favoriteList: const []),
      });

  factory AppState.loading() => const AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<RepoEntity> repoList,
    List<RepoEntity> favorites,
  }) {
    return new AppState(
        isLoading: isLoading ?? this.isLoading,
        repoList: repoList ?? this.repoList,
        favoriteState: favorites ?? this.favoriteState
    );
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^
      repoList.hashCode ^
      favoriteState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          repoList == other.repoList &&
          favoriteState == other.favoriteState;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, repoList: $repoList, favorites: $favoriteState}';
  }
}
