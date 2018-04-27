import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';

import 'package:spike_redux_flutter/redux/middleware/fetch_repo_list_midleware.dart';
import 'package:spike_redux_flutter/redux/reducer/app_state_reducer.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/models/repo_entity.dart';
import 'package:spike_redux_flutter/ui/github_list_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.loading(),
    middleware: [fetchRepoListMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store:store,
      child: new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primaryColor: Colors.green,
        ),
        home:
          new StoreBuilder<AppState>(
          onInit: (store) => store.dispatch(new FetchRepoListAction("ko2")),
          builder: (context, store) {
            return new GithubListWidget(store);
          },
        )
      )
    );
  }
}


