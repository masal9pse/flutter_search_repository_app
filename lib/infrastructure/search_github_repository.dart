import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:retrofit/retrofit.dart';

part 'search_github_repository.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class SearchGithubRepository {
  factory SearchGithubRepository(Dio dio, {String baseUrl}) = _SearchGithubRepository;

  @GET('/search/repositories')
  Future<SearchApiModel> getApiListInfo(@Query('q') String input);
}