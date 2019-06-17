import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      distinct: true,
      converter: (Store<AppState> store) => store.state.isLoading,
      builder: (context, isLoading) {
        return (isLoading)
            ? Container(
                decoration: const BoxDecoration(color: Color(0x44000000)),
                child: Center(child: const CircularProgressIndicator()),
              )
            : Container();
      },
    );
  }
}
