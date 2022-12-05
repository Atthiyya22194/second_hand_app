import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/models/product_response.dart';

import '../common/common.dart';
import '../models/product_detail_response.dart';

class MarketRepository {
  Future<List<ProductResponse>> getProducts() async {
    final queryParameters = {
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

  Future<ProductDetailResponse> getDetail(String id) async {
    final response = await http.get(Uri.parse('${baseUrl()}buyer/product/$id'));
    if (response.statusCode == 200) {
      final result = ProductDetailResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
