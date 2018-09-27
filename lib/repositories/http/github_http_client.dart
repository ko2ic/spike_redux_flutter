import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spike_redux_flutter/models/search_result_dto.dart';

class GithubHttpClient {
  static const _BASE_URL = 'https://api.github.com';

  Future<SearchResultDto> fetch(String freeword) async {
    final response = await http.get('$_BASE_URL/search/repositories?q=$freeword&page=1');
    final responseJson = json.decode(response.body);
    return new SearchResultDto.fromJson(responseJson);
  }
}
