import '../models/movie.dart';
import 'package:dio/dio.dart';
import 'Api_Urls.dart';
import 'dart:convert';

class ApiServices {
  Future<List<Movie>> fetchMovie_dio() async {
    try {
      final response = await Dio().get(ApiUrls().API);
      final String jsonBody = jsonEncode(response.data);
      final int? statusCode = response.statusCode;

      if (statusCode != 200) {
        print(response.statusMessage);
        throw Exception("Lỗi load api");
      }

      const JsonDecoder decoder = JsonDecoder();
      final movieListContainer = decoder.convert(jsonBody);
      final List movieList = movieListContainer['results'];
      return movieList.map((contactRaw) => Movie.fromJson(contactRaw)).toList();
    } catch (e) {
      print(e.toString());
      throw Exception("Lỗi load api");
    }
  }
}
