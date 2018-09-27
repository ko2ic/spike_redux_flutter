import 'dart:async';

import 'package:spike_redux_flutter/models/hoge_entity.dart';
import 'package:spike_redux_flutter/repositories/http/hoge_http_client.dart';

class HogeRepository {
  final HogeHttpClient _client;

  HogeRepository(this._client);

  Future<HogeEntity> fetch() {
    return _client.fetch();
  }

  String getSomething() {
    return "A";
  }

  void doNothing() {}
}
