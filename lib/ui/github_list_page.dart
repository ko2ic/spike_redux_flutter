import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/ui/widgets/loading_widget.dart';

class GithubListWidget extends StatefulWidget {
  Store<AppState> _store;

  GithubListWidget(Store<AppState> store) {
    this._store = store;
  }

  @override
  createState() {
    return new GithubListPage(this._store);
  }
}

class GithubListPage extends State<GithubListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SearchBar searchBar;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  GithubListPage(Store<AppState> store) {
    searchBar = new SearchBar(
        inBar: false,
        setState: (fn) => fn(), // searchbar表示のため
        onSubmitted: (freeword) =>
            store.dispatch(new FetchRepoListAction(freeword)),
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('GitHub検索'),
      actions: <Widget>[
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: new StoreConnector(
          converter: _ViewModel.fromStore,
          builder: (context, viewModel) {
            var list = viewModel.repoList;
            return new LoadingWidget(onCompleted: () {
              return new ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return _buildRow(list[i], viewModel);
                  });
            });
          }),
    );
  }

  Widget _buildRow(RepoEntity entity, _ViewModel viewModel) {
    bool isFavorite = viewModel.favorites.contains(entity);
    return new Container(
      key: new ObjectKey(entity.fullName),
      child: new Column(
        children: <Widget>[
          new ListTile(
              title: new Text(
                entity.fullName,
                style: _biggerFont,
              ),
              subtitle: new Text(entity.stars.toString()),
              trailing: new IconButton(
                  icon: new Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    viewModel.onFavoriteChanged(entity);
                  }),
              onTap: () {
                // TODO 何か処理
              }),
          new Divider(),
        ],
      ),
    );
  }
}

class _ViewModel {
  final bool loading;
  final List<RepoEntity> repoList;
  final Function(RepoEntity) onFavoriteChanged;
  final List<RepoEntity> favorites;

  _ViewModel(
      {@required this.loading,
      @required this.repoList,
      @required this.onFavoriteChanged,
      @required this.favorites});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        loading: store.state.isLoading,
        repoList: store.state.repoList,
        onFavoriteChanged: (entity) {
          store.dispatch(new FavoriteAction(
              store.state.favoriteState.favoriteList, entity));
        },
        favorites: store.state.favoriteState.favoriteList);
  }

  @override
  int get hashCode =>
      loading.hashCode ^
      repoList.hashCode ^
      favorites.hashCode ^
      onFavoriteChanged.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          repoList == other.repoList &&
          favorites == other.favorites &&
          onFavoriteChanged == other.onFavoriteChanged;
}
