
import 'package:meta/meta.dart';
import 'package:spike_redux_flutter/models/favorite_state.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<RepoEntity> repoList;
  final FavoriteState favoriteState;

  AppState(
      {
        this.isLoading = false,
        this.repoList = const [],
        this.favoriteState = const FavoriteState(favoriteList: const []),
      });

  factory AppState.loading() => new AppState(isLoading: true);

  AppState copyWith({
    bool isLoading,
    List<RepoEntity> repoList,
    FavoriteState favoriteState,
    FavoriteItemState favoriteItemState
  }) {
    return new AppState(
        isLoading: isLoading ?? this.isLoading,
        repoList: repoList ?? this.repoList,
        favoriteState: favoriteState ?? this.favoriteState,
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
    return 'AppState{isLoading: $isLoading, repoList: $repoList, favoriteState: $favoriteState}';
  }
}
