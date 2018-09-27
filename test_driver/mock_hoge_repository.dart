import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/repositories/hoge_repository.dart';

class MockHogeRepository implements HogeRepository {
  @override
  Future<HogeEntity> fetch() {
    return Future.value(HogeEntity(fuga: 'fugafuga'));
  }

  @override
  void doNothing() {
    // TODO: implement doNothing
  }

  @override
  String getSomething() {
    // TODO: implement getSomething
  }
}
