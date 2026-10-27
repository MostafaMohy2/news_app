import 'package:dio/dio.dart';
import 'package:news_app/core/models/sources_response.dart';

class ApiManager {
  final dio = Dio();

  final String apikey = '3c2aecc91f314b8c8c15674eafe01803';

  ApiManager() {
    dio.options = BaseOptions(
      baseUrl: 'https://newsapi.org',
      receiveTimeout: Duration(milliseconds: 3000),
      sendTimeout: Duration(milliseconds: 3000),
      connectTimeout: Duration(milliseconds: 3000),
      headers: {"Authorization": "3c2aecc91f314b8c8c15674eafe01803"},
    );
  }

  Future<SourcesResponse> getSources(String category) async {
    Response response = await dio.get("/v2/top-headlines/sources", queryParameters: {
      "category":category
    });
    return SourcesResponse.fromJson(response.data);
  }
}
