import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/actions/actions.dart';
import 'package:spike_redux_flutter/models/app_state.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';


class GithubListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  SearchBar searchBar;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  GithubListPage(Store<AppState> store){
    searchBar = new SearchBar(
        inBar: false,
        setState: (fn) => fn(), // searchbar表示のため
        onSubmitted: (freeword) => store.dispatch(new FetchRepoListAction(freeword)),
        buildDefaultAppBar: buildAppBar
    );
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
    return new StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (context, viewModel) {
        var list = viewModel.repoList;
        return new Scaffold(
          appBar: searchBar.build(context),
          key: _scaffoldKey,
          body: new ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: list.length,
              itemBuilder: (context, i) {
                return _buildRow(list[i], viewModel);
              }),
        );
      },
    );
  }

  Widget _buildRow(RepoEntity entity, _ViewModel viewModel) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new ListTile(
                title: new Text(
                  entity.fullName,
                  style: _biggerFont,
                ),
                subtitle: new Text(
                    entity.stars.toString()
                ),
                trailing: new IconButton(
                    icon: new Icon(
                      entity.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: entity.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      viewModel.onFavoriteChanged(entity);
                    }),
                onTap: () {
                  // TODO 何か処理
                }
            ),
            new Divider(),
          ],
        ),
      );
  }
}

class _ViewModel {
  final List<RepoEntity> repoList;
  final Function(RepoEntity) onFavoriteChanged;
  final List<RepoEntity> favoriteList;


  _ViewModel({
    @required this.repoList,
    @required this.onFavoriteChanged,
    @required this.favoriteList,
  });

  static _ViewModel fromStore(Store<AppState> store){
    return new _ViewModel(
        repoList: store.state.repoList,
        onFavoriteChanged: (entity) {
          store.dispatch(new FavoriteAction(entity));
        },
        favoriteList: store.state.favoriteState.favoriteList,
    );
  }
}

