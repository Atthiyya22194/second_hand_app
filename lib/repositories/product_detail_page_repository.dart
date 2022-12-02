import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/common/common.dart';
import 'package:second_hand_app/models/product_detail_response.dart';

class ProductDetailPageRepository {
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
