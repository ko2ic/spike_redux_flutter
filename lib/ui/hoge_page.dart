import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/action/actions.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/ui/hoge_2_page.dart';

class HogePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HogePageState();
  }
}

class HogePageState extends State<HogePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hogeページ'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        onInit: (store) => store.dispatch(HogeAction()),
        converter: _ViewModel.fromStore,
        builder: (context, viewModel) {
          return Column(
            children: <Widget>[
              InkWell(
                key: ValueKey('ToHoge2Key'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Hoge2Page())),
                child: Text(viewModel.fuga),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final String fuga;

  _ViewModel({
    @required this.fuga,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      fuga: store.state.hogeState.fuga,
    );
  }
}
