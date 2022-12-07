import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/models/notification_response.dart';
import 'package:second_hand_app/models/product_response.dart';

import '../common/common.dart';
import '../models/product_detail_response.dart';

class MarketRepository {
  Future<List<ProductResponse>> getProducts(String productName) async {
    final queryParameters = {
      'page': '1',
      'per_page': "30",
      'search': productName
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

  Future<ProductDetailResponse> getDetail({required String id}) async {
    final response = await http.get(Uri.parse('${baseUrl()}buyer/product/$id'));

    if (response.statusCode == 200) {
      final result = ProductDetailResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> order(
      {required String accessToken,
      required String productId,
      required String bidPrice}) async {
    final body = {'product_id': productId, 'bid_price': bidPrice};
    final header = {'access_token': accessToken};
    final response = await http.post(Uri.parse('${baseUrl()}buyer/order'),
        body: body, headers: header);

    if (response.statusCode == 201) {
      return 'Order Successful';
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message']);
    }
  }

  Future<List<NotificationResponse>> getNotification(
      {required String accessToken, required String type}) async {
    final queryParameters = {'notification_type': type};
    final header = {'access_token': accessToken};
    final response = await http.get(Uri.parse('${baseUrl()}notification')
        .replace(queryParameters: queryParameters),headers: header);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => NotificationResponse.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
