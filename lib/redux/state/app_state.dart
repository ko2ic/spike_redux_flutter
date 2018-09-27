import 'package:flutter/foundation.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/redux/state/favorite_state.dart';
import 'package:spike_redux_flutter/redux/state/hoge_state.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<RepoEntity> repoList;
  final FavoriteState favoriteState;
  final HogeState hogeState;

  const AppState({
    this.isLoading = false,
    this.repoList = const [],
    this.favoriteState = const FavoriteState(favoriteList: const []),
    this.hogeState = const HogeState(),
  });

  factory AppState.loading() => const AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<RepoEntity> repoList,
    List<RepoEntity> favorites,
    HogeState hogeState,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      repoList: repoList ?? this.repoList,
      favoriteState: favorites ?? this.favoriteState,
      hogeState: hogeState ?? this.hogeState,
    );
  }

  @override
  int get hashCode => isLoading.hashCode ^ repoList.hashCode ^ favoriteState.hashCode ^ hogeState.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState && runtimeType == other.runtimeType && isLoading == other.isLoading && repoList == other.repoList && favoriteState == other.favoriteState && hogeState == other.hogeState;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, repoList: $repoList, favorites: $favoriteState, hogeState: $hogeState';
  }
}
