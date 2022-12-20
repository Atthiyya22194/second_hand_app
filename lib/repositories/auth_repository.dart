import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/common.dart';
import '../models/login_response.dart';
import '../models/user_response.dart';

class AuthRepository {
  Future<LoginResponse> login(
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

  Future<String> register(
      {required String fullName,
      required String email,
      required String password,
      required String phoneNumber,
      required String address,
      required String city}) async {
    final body = {
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'address': address,
      'city': city
    };

    final response =
        await http.post(Uri.parse('${baseUrl()}auth/register'), body: body);
    if (response.statusCode == 201) {
      return 'Register Success';
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message']);
    }
  }

  Future<UserResponse> getUser({
    required String accessToken,
  }) async {
    final header = {
      'access_token': accessToken,
    };

    final response =
        await http.get(Uri.parse('${baseUrl()}auth/user'), headers: header);
    if (response.statusCode == 200) {
      final result = UserResponse.fromJson(json.decode(response.body));
      return result;
    } else {
      final error = json.decode(response.body);
      throw Exception(error['message']);
    }
  }

  Future<String> editProfile({
    required String accessToken,
    required String fullName,
    required String address,
    required String phoneNumber,
    required String city,
  }) async {
    final headers = {'access_token': accessToken};
    final body = {
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
      'city': city
    };

    final response = await http.put(Uri.parse('${baseUrl()}auth/user'),
        headers: headers, body: body);

    if (response.statusCode == 200) {
      return 'Successfuly updated';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
