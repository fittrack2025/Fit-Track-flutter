import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trial/homepage.dart';
import 'package:trial/services/loginapi.dart';

final Dio _dio = Dio();

Future<Map<String, dynamic>> registerApi(datass, context) async {
  try {
    print('3444');
    print(datass);
    final response = await _dio.post('$baseUrl/register', data: datass);
    print('lllll');
    if (response.statusCode == 201) {
      // Assuming 201 for successful registration
      Navigator.push(context, MaterialPageRoute(builder: (ctxt) => HomePage()));
      return {
        'success': true,
        'data': response.data,
      };
    } else {
      return {
        'success': false,
        'message': response.data['message'] ?? 'Registration failed',
      };
    }
  } on DioError catch (e) {
    return {
      'success': false,
      'message': e.response?.data['message'] ?? 'An error occurred',
    };
  }
}
