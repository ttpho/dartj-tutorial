import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

import 'dart:convert';

class BaseResponse<T, R> {
  static T fromJsonDioResponse<T, R>(
    dio.Response response,
    R Function(Map<String, dynamic>) fromJson,
  ) {
    final object = response.data;
    return BaseResponse.fromJson(object, fromJson);
  }

  static T fromJsonHttpResponse<T, R>(
    http.Response response,
    R Function(Map<String, dynamic>) fromJson,
  ) {
    final object = json.decode(response.body);
    return BaseResponse.fromJson(object, fromJson);
  }

  static T fromJson<T, R>(
    Object? json,
    R Function(Map<String, dynamic>) fromJson,
  ) {
    if (json is Map<String, dynamic>) {
      return fromJson.call(json) as T;
    }
    if (json is List) {
      return json.map((e) => fromJson.call(e as Map<String, dynamic>)).toList()
          as T;
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
