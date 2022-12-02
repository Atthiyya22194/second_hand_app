import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_response.dart';

class HomePageRepository {
  static const String _baseUrl =
      'https://market-final-project.herokuapp.com/buyer/product';

  Future<List<ProductResponse>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => ProductResponse.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
