import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:second_hand_app/models/login_response.dart';

import '../common/common.dart';

class AuthRepository {
  Future<LoginResponse> getProducts(
      {required String email, required String password}) async {
    final body = {'email': email, 'password': password};

    final response =
        await http.post(Uri.parse('${baseUrl()}auth/login'), body: body);
    if (response.statusCode == 201) {
      final result = LoginResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message']);
    }
  }
}
