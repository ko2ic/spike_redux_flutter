import 'dart:async';

import 'package:spike_redux_flutter/models/search_result_dto.dart';
import 'package:spike_redux_flutter/repositories/http/github_http_client.dart';



class GithubRepositoryImpl {

  Future<SearchResultDto> fetch(String freeword){
    GithubHttpClient client = new GithubHttpClient();
    return client.fetch(freeword);
  }
}