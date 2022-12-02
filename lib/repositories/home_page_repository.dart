import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_response.dart';

class HomePageRepository {
  static const String _baseUrl = 'https://market-final-project.herokuapp.com/';

  Future<List<ProductResponse>> getProducts() async {
    final queryParameters = {
      'status': 'available',
      'page': '1',
      'per_page': "30"
    };

    final response = await http.get(Uri.parse('${_baseUrl}buyer/product')
        .replace(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => ProductResponse.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
