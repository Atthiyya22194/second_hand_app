import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import 'package:http_parser/http_parser.dart';
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
    final response = await http.get(
        Uri.parse('${baseUrl()}notification')
            .replace(queryParameters: queryParameters),
        headers: header);

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => NotificationResponse.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> uploadProduct(
      {required String accessToken,
      required String productname,
      required String description,
      required String basePrice,
      required String category,
      required String location,
      required File image}) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl()}seller/product'));

    var stream = http.ByteStream(image.openRead());
    stream.cast();
    var length = await image.length();

    var multipartFile = http.MultipartFile('image', stream, length,
        filename: path.basename(image.path),
        contentType: MediaType('image', 'png'));

    request.files.add(multipartFile);
    request.headers['access_token'] = accessToken;
    request.fields['name'] = productname;
    request.fields['description'] = description;
    request.fields['base_price'] = basePrice;
    request.fields['category_ids'] = category;
    request.fields['location'] = location;

    final response = await request.send();

    if (response.statusCode == 201) {
      return 'Successfuly upload';
    } else {
      throw Exception(response.stream.bytesToString());
    }
  }
}
