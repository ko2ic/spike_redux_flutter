import 'package:spike_redux_flutter/models/repo_entity.dart';

class LoadCompleteAction {}
class LoadingAction {}

class FetchRepoListAction {
  final String keyword;
  const FetchRepoListAction(this.keyword);
}

class FetchRepoListSucceededAction {
  final List<RepoEntity> items;
  const FetchRepoListSucceededAction(this.items);
}

class FetchRepoListFailedAction {
  final Exception error;
  const FetchRepoListFailedAction(this.error);
}

class FavoriteAction{
  final List<RepoEntity> favorites;
  final RepoEntity target;
  const FavoriteAction(this.favorites, this.target);
}
