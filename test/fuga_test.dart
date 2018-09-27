import 'package:mockito/mockito.dart';
import 'package:spike_redux_flutter/models/hoge.dart';
import 'package:test/test.dart';

class MockHoge extends Mock implements Hoge {}

main() {
  test('fuga1()', () {
    var mockHoge = MockHoge();
    var target = Fuga(mockHoge);
    when(mockHoge.doNothing()).thenReturn(null);
    target.fuga1();

    verify(mockHoge.doNothing());
  });

  test('fuga2()', () {
    var mockHoge = MockHoge();
    var target = Fuga(mockHoge);

    when(mockHoge.methodA(nameA: anyNamed("nameA"))).thenReturn("1");

    target.fuga2();

    verify(mockHoge.methodA(
      nameA: argThat(equals("fuga"), named: "nameA"),
    ));
  });

  test('fuga3()', () {
    var mockHoge = MockHoge();
    var target = Fuga(mockHoge);

    when(mockHoge.methodB(any)).thenAnswer((Invocation invocation) {
      var func = invocation.positionalArguments.first;
      return func();
    });

    // テスト対象
    var actual = target.fuga3();

    expect(actual, 1);
  });
}
