import 'dart:convert';

import 'package:telestat_task/data/remote/response.dart';
import '../../utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

Future<Response> getBreakingNewsArticles (
    {required String apiKey,
    String country = 'us',
    String? category,
    String? sources,
    int? page,
    String? q,
    int? pageSize}) async {

  String countryRequest = '';
  String categoryRequest = '';
  String qRequest = '';
  String pageRequest = '';
  String pageSizeRequest = '';
  String sourcesRequest = '';

  countryRequest = '&country=$country';
  if (category != null) categoryRequest = '&category=$category';
  if (sources != null) sourcesRequest = '&sources=$sources';
  if (q != null) qRequest = '&q=$q';
  if (page != null) pageRequest = '&page=$page';
  if (pageSize != null) pageSizeRequest = '&pageSize=$pageSize';

  final url =
      Uri.parse('$baseNewsUrl/top-headlines?apiKey=$apiKey$sourcesRequest'
          '$countryRequest$categoryRequest$qRequest'
          '$pageRequest$pageSizeRequest');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Response.fromJson(json);
    } else {
      return Future.error("Server Error");
    }
  } catch (socketException) {
    return Future.error("Error Fetching Data");
  }
}
