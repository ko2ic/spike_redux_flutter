import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:spike_redux_flutter/redux/middleware/hoge_middleware.dart';
import 'package:spike_redux_flutter/redux/reducer/app_state_reducer.dart';
import 'package:spike_redux_flutter/redux/state/app_state.dart';
import 'package:spike_redux_flutter/redux/state/hoge_state.dart';
import 'package:spike_redux_flutter/ui/hoge_page.dart';
import '../test_driver/mock_hoge_repository.dart';

void main() {
  final hogeRepository = MockHogeRepository();

  final _hogeMiddleware = hogeMiddleware(hogeRepository);

  testWidgets('HogePage', (WidgetTester tester) async {
    var _store = Store<AppState>(
      appReducer,
      initialState: AppState(
        hogeState: HogeState(),
      ),
      middleware: _hogeMiddleware,
    );

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext buildContext, StateSetter setState) {
          return StoreProvider(
            store: _store,
            child: MaterialApp(home: HogePage()),
          );
        },
      ),
    );

    // reduxのonInitが呼ばれる前
    expect(find.text('fuga'), findsOneWidget);

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext buildContext, StateSetter setState) {
          return StoreProvider(
            store: _store,
            child: MaterialApp(home: HogePage()),
          );
        },
      ),
    );

    // reduxのonInitが呼ばれた後
    expect(find.text('fugafuga'), findsOneWidget);

    Text text = tester.widget(find.text('fugafuga'));

    var toHoge2 = find.byKey(ValueKey('ToHoge2Key'));
    await tester.tap(toHoge2);
    await tester.pumpAndSettle();

    expect(find.text('ページ2'), findsOneWidget);

    // テスト対象の画面に戻る
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('fugafuga'), findsOneWidget);
  });
}
