import 'dart:convert';
import 'dart:io';

import 'package:dentisia/service/custom_error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API {
  Future<dynamic> get({required String url, required String? jwt}) async {
    Map<String, String> headers = {};
    if (jwt != null) {
      headers.addAll({'Authorization': "Bearer $jwt"});
    }
    try {
      http.Response response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      throw Failure('No Internet , Please check the connection');
    } on HttpException {
      throw Failure('Couldn\'t find the case');
    } on FormatException {
      throw Failure('Bad , response format');
    } on Exception {
      throw Failure('Something is wrong is happened, Please try agin');
    }
  }

  Future<dynamic> post(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (token != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }
    try {
      http.Response response = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } on SocketException {
      throw Failure('No Internet , Please check the connection');
    } on HttpException {
      throw Failure('Couldn\'t find the case');
    } on FormatException {
      throw Failure('Bad , response format');
    } on Exception {
      throw Failure('Something is wrong is happened, Please try agin');
    }
  }

  Future<dynamic> patch(
      {required String url,
      @required dynamic body,
      @required String? token}) async {
    Map<String, String> headers = {};
    headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (token != null) {
      headers.addAll({'Authorization': "Bearer $token"});
    }
    http.Response response = await http.patch(Uri.parse(url),
        body: jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem in the statusCode ${response.statusCode} with body ${response.body}');
    }
  }

  Future<dynamic> delete({required String url, required String? jwt}) async {
    Map<String, String> headers = {};

    if (jwt != null) {
      headers.addAll({'Authorization': "Bearer $jwt"});
    }
    http.Response response =
        await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'there is a problem in the statusCode ${response.statusCode}');
    }
  }
}
