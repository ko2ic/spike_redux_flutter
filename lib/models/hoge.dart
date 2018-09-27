import 'package:spike_redux_flutter/repositories/hoge_repository.dart';

class Hoge {
  void doNothing() {}

  String methodA({String nameA}) {
    return "A";
  }

  int methodB(int Function() hogeFunc) {
    return hogeFunc();
  }
}

class Fuga {
  final Hoge hoge;

  Fuga(this.hoge);

  void fuga1() {
    hoge.doNothing();
  }

  void fuga2() {
    hoge.methodA(nameA: "fuga");
  }

  int fuga3() {
    return hoge.methodB(() {
      return 1;
    });
  }
}
