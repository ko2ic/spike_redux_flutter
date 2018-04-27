
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';

typedef T Func0<T>();

class LoadingWidget  extends StatelessWidget {
  final Func0<Widget> onCompleted;

  LoadingWidget({Key key, @required this.onCompleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.isLoading,
      builder: (context, isLoading) {
        if (isLoading) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }else{
          return onCompleted();
        }
      },
    );
  }
}
