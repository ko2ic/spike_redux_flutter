import 'package:spike_redux_flutter/models/repo_entity.dart';

class RepoListNotLoadedAction {}
class RepoListLoadedAction {
  final List<RepoEntity> repoList;
  RepoListLoadedAction(this.repoList);
  @override
  String toString() {
    return 'RepoListLoadedAction{repoList: $repoList}';
  }
}

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
  final RepoEntity entity;
  const FavoriteAction(this.entity);
}
