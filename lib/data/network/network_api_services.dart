// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_mvvm/data/app_exception.dart';
import 'package:flutter_mvvm/data/network/base_api_services.dart';
import 'package:flutter_mvvm/shared/shared.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.https(Const.baseUrl, endpoint),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
            'key': Const.apiKey
          });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Network request timeout');
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String endpoint, dynamic data) async {
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.https(Const.baseUrl, Const.apiPath + endpoint),
              headers: {
                'key': Const.apiKey,
                'content-type': 'application/x-www-form-urlencoded',
              },
              body: data);
      print("URL: ${Uri.https(Const.baseUrl, Const.apiPath + endpoint)}");
      print("Data: $data");
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server');
    }
  }
}
