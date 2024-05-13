import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../modules/search/models/image_model.dart';
import '../api_constants.dart';

class PixabayApiService {
  static Future<List<ImageModel>?> getImagesWithSearchQuery(String? query,int page) async {
    final uri = Uri.https(
      ApiConstants.urlPixaBay,
      '/api/',
      {
        'key': ApiConstants.apiKeyPixaBay,
        'q': query,
        'image_type': 'photo',
        'order': 'popular',
        'page': '$page',
        'per_page': '40',
      },
    );
    print('===uri===' + uri.toString());

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse['errors'] != null) {
      return [];
    }

    return ImageModel.listFromJson(jsonResponse['hits']);
  }

  static Future<dynamic> _getJson(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        return null;
      }

      return json.decode(response.body);
    } catch (e) {
      print('$e');
      return null;
    }
  }
}
