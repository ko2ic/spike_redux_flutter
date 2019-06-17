import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/middleware/fetch_repo_list_midleware.dart';
import 'package:spike_redux_flutter/redux/reducer/app_state_reducer.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/repositories/github_repository_impl.dart';
import 'package:spike_redux_flutter/ui/github_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static GithubRepositoryImpl repository = GithubRepositoryImpl();
  var store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: fetchRepoListMiddleware(repository),
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: StoreConnector<AppState, bool>(
          distinct: true,
          onInit: (store) => store.dispatch(FetchRepoListAction("ko2")),
          converter: (store) => true,
          builder: (context, _) {
            return GithubListPage();
          },
        ),
      ),
    );
  }
}
