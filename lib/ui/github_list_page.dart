import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/ui/widgets/loading_widget.dart';

class GithubListWidget extends StatefulWidget {
  @override
  createState() {
    return GithubListPage();
  }
}

class GithubListPage extends State<GithubListWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 本来はStoreProviderで取得するので、不要だがflutter_search_barを利用指定いるために必要になっている
  Store<AppState> _store;

  SearchBar searchBar;
  final _biggerFont = const TextStyle(fontSize: 18.0);

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('GitHub検索'),
      actions: <Widget>[
        searchBar.getSearchAction(context),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    searchBar = SearchBar(
        inBar: false,
        setState: (fn) => fn(), // searchbar表示のため
        onSubmitted: (freeword) => _store.dispatch(FetchRepoListAction(freeword)),
        buildDefaultAppBar: buildAppBar);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = StoreProvider.of<AppState>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: StoreConnector(
          converter: _ViewModel.fromStore,
          builder: (context, viewModel) {
            var list = viewModel.repoList;
            return LoadingWidget(onCompleted: () {
              return ListView.builder(
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
    return Container(
      key: ObjectKey(entity.fullName),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                entity.fullName,
                style: _biggerFont,
              ),
              subtitle: Text(entity.stars.toString()),
              trailing: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    viewModel.onFavoriteChanged(entity);
                  }),
              onTap: () {
                // TODO 何か処理
              }),
          Divider(),
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

  _ViewModel({@required this.loading, @required this.repoList, @required this.onFavoriteChanged, @required this.favorites});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
        loading: store.state.isLoading,
        repoList: store.state.repoList,
        onFavoriteChanged: (entity) {
          store.dispatch(FavoriteAction(store.state.favoriteState.favoriteList, entity));
        },
        favorites: store.state.favoriteState.favoriteList);
  }

  @override
  int get hashCode => loading.hashCode ^ repoList.hashCode ^ favorites.hashCode ^ onFavoriteChanged.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel && runtimeType == other.runtimeType && loading == other.loading && repoList == other.repoList && favorites == other.favorites && onFavoriteChanged == other.onFavoriteChanged;
}
