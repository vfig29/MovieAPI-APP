import 'dart:convert';

import 'package:desafiomovieapi/MovieAPI/Movie.dart';
import 'package:http/http.dart' as http;

abstract class APIRequest<ResponseType extends APIResponse> {
  final String authority = 'api.themoviedb.org';
  String _requestPath;
  final String _apiKey;

  APIRequest(this._apiKey);

  Future<ResponseType> fetchRequest({dynamic entry}) async {
    Map<String, dynamic> _queryParameters = {
      'api_key': _apiKey,
      'page': entry.toString(),
    };
    //adicionar o uso da entry opcional
    http.Response response =
        await http.get(Uri.https(authority, _requestPath, _queryParameters));
    return apiResponseValidator(response);
  }

  Future<ResponseType> apiResponseValidator(http.Response requestResponse);
}

class APIUpcomingRequest extends APIRequest<UpcomingMovies> {
  @override
  String _requestPath = '/3/movie/upcoming';

  APIUpcomingRequest(String _apiKey) : super(_apiKey);

  Future<UpcomingMovies> apiResponseValidator(
      http.Response requestResponse) async {
    switch (requestResponse.statusCode) {
      case 200:
        return UpcomingMovies.fromJSON(jsonDecode(requestResponse.body));
        break;
      default:
        return Future.error("We couldn't find any upcoming movies.");
    }
  }
}
