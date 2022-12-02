import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/models/product_response.dart';

import '../common/common.dart';

class HomePageRepository {
  Future<List<ProductResponse>> getProducts() async {
    final queryParameters = {
      'status': 'available',
      'page': '1',
      'per_page': "30"
    };

    final response = await http.get(Uri.parse('${baseUrl()}buyer/product')
        .replace(queryParameters: queryParameters));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => ProductResponse.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
