import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spike_redux_flutter/models/hoge_entity.dart';

class HogeHttpClient {
  final String baseUrl;
  static HogeHttpClient _instance;

  factory HogeHttpClient({String baseUrl = 'https://hoge.com'}) {
    if (_instance == null) {
      _instance = new HogeHttpClient._internal(baseUrl);
    }
    return _instance;
  }

  HogeHttpClient._internal(this.baseUrl);

  Future<HogeEntity> fetch() async {
    final response = await http.get('$baseUrl/hoge');
    final responseJson = json.decode(response.body);
    return new HogeEntity.fromJson(responseJson);
  }
}
