import 'dart:convert';
import 'dart:io';

import 'package:city_hub/data/app_exceptions.dart';
import 'package:city_hub/data/network/base_api_services.dart';
import 'package:city_hub/data/services/token_storage.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {

  final TokenStorage _tokenStorage = TokenStorage();

  Future<Map<String, String>> _getHeaders({bool withAuth = false}) async {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (withAuth) {
      final token = await _tokenStorage.getToken();
      if (token != null) {
        headers["Authorization"] = "Bearer $token";
      }
    }
    return headers;
  }

  @override
  Future<dynamic> getDeleteApiResponse(
    String url,
    String password, {
    bool withAuth = false,
  }) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders(withAuth: withAuth);
      final response = await http
          .delete(Uri.parse(url),headers: headers,)
          .timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FatchDataExecption("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future<dynamic> getGetApiResponse(String url, {bool withAuth = false}) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders(withAuth: withAuth);
      final response = await http
          .get(Uri.parse(url),headers: headers,)
          .timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FatchDataExecption("No Internet Connection");
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(
    String url,
    dynamic body, {
    bool withAuth = false,
  }) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders(withAuth: withAuth);
      dynamic response = await http
          .post(Uri.parse(url), body: jsonEncode(body),headers: headers,)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FatchDataExecption("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future<dynamic> getPutApiResponse(
    String url,
    dynamic body, {
    bool withAuth = false,
  }) async {
    dynamic responseJson;
    try {
      final headers = await _getHeaders(withAuth: withAuth);
      dynamic response = http
          .put(Uri.parse(url), body: jsonEncode(body),headers: headers,)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FatchDataExecption("No Internet Connection");
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 201:
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        }
        return null;
      case 400:
        throw BadRequestExecption("Body not passes properly");
      default:
        throw FatchDataExecption("Url give status code ${response.statusCode}");
    }
  }
}
