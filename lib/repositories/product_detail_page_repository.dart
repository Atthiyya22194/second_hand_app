import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/models/product_response.dart';

class ProductDetailPageRepository {
  static const String _baseUrl =
      'https://market-final-project.herokuapp.com/buyer/product/';

  Future<ProductResponse> getDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + id));
    if (response.statusCode == 200) {
      final result = ProductResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
